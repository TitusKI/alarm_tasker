import 'package:flutter/material.dart';

class DueDatePicker extends StatefulWidget {
  const DueDatePicker({super.key});

  @override
  _DueDatePickerState createState() => _DueDatePickerState();
}

class _DueDatePickerState extends State<DueDatePicker> {
  DateTime? selectedDateTime;

  Future<void> _pickDateTime() async {
    // Pick Date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Pick Time after Date is selected
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Due Date Picker")),
      body: Center(
        child: buildDateTile(
          "Due Date",
          selectedDateTime != null
              ? "${selectedDateTime!.toLocal()}".split('.')[0]
              : "Tap to select due date",
        ),
      ),
    );
  }

  Widget buildDateTile(String title, String value) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      trailing: Icon(Icons.calendar_today),
      onTap: _pickDateTime,
    );
  }
}
