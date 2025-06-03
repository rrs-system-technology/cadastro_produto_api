import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;
  final bool isRequired;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextInputAction textInputAction;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
    this.isRequired = true,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
      ),
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Informe o(a) $label';
        }
        return null;
      },
    );
  }
}
