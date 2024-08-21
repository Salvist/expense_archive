import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/domain/models/business.dart';
import 'package:simple_expense_tracker/domain/models/expense_category.dart';
import 'package:simple_expense_tracker/app/providers/business_provider.dart';
import 'package:simple_expense_tracker/domain/repositories/business_repository.dart';
import 'package:simple_expense_tracker/domain/repositories/repository_provider.dart';

class BusinessField extends StatefulWidget {
  final ExpenseCategory? category;
  final Business? value;
  final void Function(Business? value)? onSelected;
  final String? Function(String? value)? validator;

  const BusinessField({
    super.key,
    required this.category,
    this.value,
    this.onSelected,
    this.validator,
  });

  @override
  State<BusinessField> createState() => _BusinessFieldState();
}

class _BusinessFieldState extends State<BusinessField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  bool _showKeyboard = false;

  late Iterable<Business> _businesses;

  late final BusinessRepository _businessRepository;

  @override
  void initState() {
    _businessRepository = RepositoryProvider.businessOf(context);
    // _businessRepository.getByCategory(widget.category!);
    _focusNode.addListener(() {});
    super.initState();
  }

  @override
  void didUpdateWidget(BusinessField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.category != widget.category && widget.category != null) {
      // _businesses = BusinessProvider.of(context).byCategory(widget.category!);
      _businessRepository.getByCategory(widget.category!).then((value) {
        setState(() {
          _businesses = value;
        });
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _controller.clear();

          if (_businesses.length == 1) {
            final business = _businesses.first;
            _controller.text = business.name;
            if (widget.onSelected != null) widget.onSelected!(business);
          }
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    // if (widget.category != null) {
    //   _businesses = BusinessProvider.of(context).byCategory(widget.category!);
    // }
    super.didChangeDependencies();
  }

  void _setBusiness(String option) {
    Business business;
    if (option.contains('Add')) {
      final start = option.indexOf('"') + 1;
      final end = option.lastIndexOf('"');
      final businessName = option.substring(start, end);
      business = Business(name: businessName, categoryName: widget.category!.name);
      // BusinessNotifier.of(context).addBusiness(business);
    } else {
      business = _businesses.firstWhere((business) => business.name == option);
    }
    _controller.text = business.name;
    _focusNode.unfocus();
    if (widget.onSelected != null) widget.onSelected!(business);
  }

  Widget _buildIcon() {
    if (widget.value != null) {
      return IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () {
          if (widget.onSelected != null) {
            widget.onSelected!(null);
            _controller.clear();
          }
        },
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.arrow_drop_down_rounded),
        onPressed: () {
          setState(() {
            _showKeyboard = false;
          });
          _focusNode.requestFocus();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      focusNode: _focusNode,
      textEditingController: _controller,
      onSelected: _setBusiness,
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          onTapOutside: (event) {
            focusNode.unfocus();
          },
          onChanged: (value) {
            if (widget.onSelected != null) widget.onSelected!(null);
          },
          onTap: () {
            setState(() {
              _showKeyboard = true;
            });
          },
          enabled: widget.category != null,
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Business / Individual',
            suffixIcon: _buildIcon(),
          ),
          readOnly: !_showKeyboard,
          textCapitalization: TextCapitalization.words,
          //TODO: Change this to use errorText in decoration. Remove error text when an option is selected
          validator: widget.validator,
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Theme.of(context).colorScheme.secondaryContainer,
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 240.0,
                maxWidth: MediaQuery.of(context).size.width - 32,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(option),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      optionsBuilder: (textEditingValue) {
        // if (textEditingValue.text == '' || widget.category == null) {
        //   return const Iterable<String>.empty();
        // }
        if (widget.category == null) {
          return const Iterable<String>.empty();
        }

        final names = _businesses.map((e) => e.name);
        if (textEditingValue.text == '') return names;

        final matchingNames = names.where((name) => name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
        return matchingNames.isNotEmpty ? matchingNames : ['Add "${textEditingValue.text}"'];
      },
    );
  }
}
