import 'package:flutter/material.dart';
typedef ValidatorFunction = String? Function(String? value);
class BuildTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool isPassword;
  final TextEditingController? controller;
  final ValidatorFunction? validator;
  final void Function(String)? onChanged;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final Widget? suffixIcon;

  const BuildTextFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.onToggleVisibility,
    this.suffixIcon,
    bool readOnly = false,
    bool enableInteractiveSelection = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: isPassword ? obscureText : false,
        obscuringCharacter: "*",
        style: const TextStyle(color: Colors.black, fontSize: 15),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(color: Colors.black87, fontSize: 20),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 12,
          ),
          suffixIcon:
              suffixIcon ??
              (isPassword && onToggleVisibility != null
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: onToggleVisibility,
                    )
                  : null),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: _buildBorder(const Color(0xFF8C8C8C)),
          focusedBorder: _buildBorder(Colors.black),
          errorBorder: _buildBorder(Colors.red),
          focusedErrorBorder: _buildBorder(Colors.red),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }
}
