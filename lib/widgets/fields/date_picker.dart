import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/utils/extensions/date_time_extension.dart';

class DatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final void Function(DateTime? date) onSelectedDate;

  const DatePicker({
    super.key,
    this.selectedDate,
    required this.onSelectedDate,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final _controller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.text = widget.selectedDate?.format('yMMMd') ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.event_rounded),
        label: Text('Date'),
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: widget.selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (date != null) _controller.text = date.format('yMMMd');
        widget.onSelectedDate(date);
      },
    );
  }
}
