import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/theme_controller.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hint;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final themeMode = Get.find<ThemeController>().themeMode;

    return DropdownButtonFormField<String>(
      value: value != '' ? value : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      isExpanded: true,
      icon: Icon(
        Icons.arrow_drop_down,
        color: themeMode.value == ThemeMode.dark ? Colors.white : Colors.black,
      ),
      dropdownColor: colorScheme.surface,
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 16,
      ),
      items: items.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
