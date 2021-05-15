import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({this.controller});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Password',
          suffixIcon: IconButton(
            onPressed: () =>
                setState(() => isPasswordVisible = !isPasswordVisible),
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        obscureText: !isPasswordVisible,
      ),
    );
  }
}
