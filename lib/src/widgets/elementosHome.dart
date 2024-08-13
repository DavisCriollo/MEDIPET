import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neitorcont/src/utils/responsive.dart';



class ElementosHome extends StatelessWidget {
  final String image;
  final bool enabled;
  final String label;
  final Function() onTap;
  const ElementosHome({
    Key? key,
    required this.size,
    required this.enabled,
    required this.image,
    required this.label, 
    required this.onTap,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
     
      // splashColor: Colors.red,
      child: Container(
        margin: EdgeInsets.all(size.iScreen(1)),
        // padding: EdgeInsets.all(size.iScreen(0.5)),
        decoration: BoxDecoration(
            color: (enabled == false) ? const Color(0xFFcdd0cb) : Colors.white,
            borderRadius: BorderRadius.circular(size.iScreen(2.0))),
        width: size.iScreen(15.5),
        height: size.iScreen(15.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(size.iScreen(1.0)),
              // color: Colors.greenAccent,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                width: size.iScreen(8.0),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.iScreen(0.5)),
              child: Text(label,
                  style: GoogleFonts.roboto(
                      fontSize: size.iScreen(1.4),
                      color: Colors.purple[900],
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      onTap:onTap,
    );
  }
}
