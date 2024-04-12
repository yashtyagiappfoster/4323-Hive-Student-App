import 'package:flutter/material.dart';

class CustomWidgets {
  static customIconButton(
      VoidCallback voidCallback, IconData icon, Color color) {
    return IconButton(
      onPressed: voidCallback,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }

  static customTextFormField(
      TextEditingController controller, String lbText, String htText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: lbText,
          hintText: htText),
    );
  }
}
