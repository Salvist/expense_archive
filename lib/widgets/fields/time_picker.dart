import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final TimeOfDay selectedTime;
  final void Function(TimeOfDay? time) onChanged;

  const TimePicker({
    super.key,
    required this.selectedTime,
    required this.onChanged,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final _controller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.text = widget.selectedTime.format(context);
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
        label: Text('Time'),
        prefixIcon: Icon(Icons.schedule),
      ),
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: widget.selectedTime,
        );
        if (!mounted) return;
        if (pickedTime != null) _controller.text = pickedTime.format(context);
        widget.onChanged(pickedTime);
      },
    );
  }
}
