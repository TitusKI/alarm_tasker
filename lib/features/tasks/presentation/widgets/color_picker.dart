import 'package:alarm_tasker/features/theme/presentation/cubit/theme_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({super.key});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    final themeState = context.read<ThemeCubit>().state;
    selectedColor = themeState.primaryColor;
  }

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(selectedColor);
    final textColor =
        brightness == Brightness.light ? Colors.black : Colors.white;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: selectedColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('List Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 18)),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Let's give it a name...",
                      hintStyle: TextStyle(color: textColor),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
            ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: changeColor,
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false,
              displayThumbColor: true,
              paletteType: PaletteType.hueWheel,
              labelTypes: const [],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL',
                        style: TextStyle(color: Colors.orangeAccent)),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<ThemeCubit>()
                          .updatePrimaryColor(selectedColor);
                      Navigator.pop(context);
                    },
                    child: const Text('SAVE',
                        style: TextStyle(color: Colors.orangeAccent)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showColorPicker(BuildContext context) async {
  await showDialog<Color>(
    context: context,
    builder: (context) => const ColorPickerDialog(),
  );
}
