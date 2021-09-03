import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextField({
    Key? key,
    this.hint,
    this.validator,
    this.controller,
    this.obscureText,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: suffixIcon,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.red,
            )),
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
