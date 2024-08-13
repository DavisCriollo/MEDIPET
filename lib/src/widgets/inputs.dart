
import 'package:flutter/material.dart';
import 'package:neitorcont/src/utils/responsive.dart';

class InputsText extends StatelessWidget {
  final Responsive size;
  final String? label;
  final String? hintsText;
  final int? maxLines;
  final IconData? suffix;
  final TextInputType? keyboardType;
  final TextEditingController textColtroller;

  final bool obscureText;
   const InputsText({
    required this.size,
     this.label,
    required this.obscureText,
    required this.keyboardType,
    this.suffix,
    this.hintsText,
    this.maxLines=1,
     required this.textColtroller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.wScreen(100),
      // margin: EdgeInsets.only(top: size.iScreen(1.5)),
      child: TextField(
        controller: textColtroller,
      maxLines:(maxLines!>1)?maxLines!:1,
        enableInteractiveSelection: false,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintsText,
          focusedBorder: InputBorder.none,
            border: InputBorder.none,
          suffixIcon: Icon(suffix),
          labelText: label,
          labelStyle: TextStyle(fontSize: size.iScreen(1.5)),
        ),
      ),
    );
  }
}
