import 'package:flutter/material.dart';

class AuthenticationTextField extends StatelessWidget {
  const AuthenticationTextField({
    super.key,
    bool? autoCorrection,
    bool? obscuredText,
    bool? enableSuggestions,
    int? maxLength,
    TextInputType? keyboardType,
    required this.fieldLabel,
    required this.validator,
    required this.onSaved,
  })  : autoCorrection = autoCorrection ?? false,
        obscuredText = obscuredText ?? false,
        enableSuggestions = enableSuggestions ?? false,
        keyboardType = keyboardType ?? TextInputType.text;
  final String fieldLabel;
  final String? Function(String? value) validator;
  final void Function(String? newValue) onSaved;
  final bool obscuredText;
  final bool autoCorrection;
  final bool enableSuggestions;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      obscureText: obscuredText,
      keyboardType: keyboardType,
      autocorrect: autoCorrection,
      enableSuggestions: enableSuggestions,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(99, 108, 106, 106),
        filled: true,
        labelText: fieldLabel,
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
