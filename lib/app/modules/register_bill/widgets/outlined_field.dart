import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final bool enabled;
  final String? Function(String? value)? validator;
  final IconData? prefixIcon;
  const OutlinedField({
    Key? key,
    required this.controller,
    required this.label,
    this.inputFormatters,
    this.keyboardType = TextInputType.number,
    this.enabled = true,
    this.validator,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 14
          ),
        ),
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}
