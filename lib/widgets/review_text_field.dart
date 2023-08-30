import 'package:flutter/material.dart';

class ReviewTextField extends StatelessWidget {
  const ReviewTextField({
    TextInputType? keyboardType,
    int? maxLines,
    super.key,
    required this.validator,
    required this.onSaved,
    required this.labelText,
    required this.maxLength,
  })  : keyboardType = keyboardType ?? TextInputType.text,
        maxLines = maxLines ?? 1;

  final String? Function(String? value) validator;
  final void Function(String? newValue) onSaved;
  final int maxLength;
  final TextInputType keyboardType;
  final String labelText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
      maxLines: maxLines,
      onSaved: onSaved,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(99, 108, 106, 106),
        filled: true,
        labelText: labelText,
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 41, 40, 46),
          ),
        ),
        labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
      ),
    );
  }
}
