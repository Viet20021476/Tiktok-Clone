import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  const TextInputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.isObscure,
    required this.icon,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late bool obscuseText = widget.isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(widget.icon),
        labelStyle: const TextStyle(
          fontSize: 15,
          color: Color.fromRGBO(143, 148, 251, 1),
        ),
        border: InputBorder.none,
        suffixIcon: widget.isObscure
            ? InkWell(
                onTap: () {
                  setState(() {
                    obscuseText = !obscuseText;
                  });
                },
                child:
                    Icon(obscuseText ? Icons.visibility : Icons.visibility_off),
              )
            : Container(
                width: 0,
              ),
      ),
      obscureText: obscuseText,
    );
  }
}
