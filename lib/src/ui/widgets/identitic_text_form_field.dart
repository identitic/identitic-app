import 'package:flutter/material.dart';

class IdentiticTextFormField extends StatelessWidget {
  const IdentiticTextFormField({
    @required this.controller,
    @required this.focusNode,
    @required this.validator,
    @required this.labelText,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
