import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class CustomFormTextField extends StatefulWidget {
  const CustomFormTextField({
    super.key,
    this.hintText,
    this.isPassword = false,
    this.onChanged,
    this.prefixIcon,
    this.borderColor,
    this.width,
  });

  final Function(String)? onChanged;
  final String? hintText;
  final bool isPassword;
  final IconData? prefixIcon;
  final Color? borderColor;
  final double? width;

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    if (!widget.isPassword) {
      isObscure = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 80,
      child: TextFormField(
        obscureText: isObscure,
        obscuringCharacter: '*',
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
        onChanged: widget.onChanged,
        style: Styles.textStyle16,
        decoration: InputDecoration(
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.white),

          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: Colors.white)
              : null,

          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xff50535B),
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(19),
            borderSide: BorderSide(
              width: widget.width ?? 0,
              color: widget.borderColor ?? Color(0xff24262B),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(19),
            borderSide: BorderSide(color: Color(0xff24262B)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(19),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
