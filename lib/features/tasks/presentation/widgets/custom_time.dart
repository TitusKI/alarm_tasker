import 'package:flutter/material.dart';

class TimePickerScreen extends StatefulWidget {
  const TimePickerScreen({super.key});

  @override
  _TimePickerScreenState createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  Future<void> selectCustomTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Custom Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.green, // Header background color
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  selectedTime.format(context),
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Time Picker
              SizedBox(
                height: 250,
                child: TimePickerDialog(
                  initialTime: selectedTime,
                ),
              ),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, null),
                    child: const Text("CANCEL"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, selectedTime),
                    child: const Text("OK"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Time Picker")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => selectCustomTime(context),
          child: Text("Select Time: ${selectedTime.format(context)}"),
        ),
      ),
    );
  }
}
