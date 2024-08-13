import 'package:flutter/material.dart';
import 'package:neitorcont/src/utils/responsive.dart';


class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      body: Container(
        width: size.wScreen(100),
        height: size.hScreen(100),
        color: Color(0xFFDEEAF6),
        child: CustomPaint(
          painter: _HeaderPaint(),
        ),
      ),
    );
  }
}

class _HeaderPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
      center: const Offset(350.0, -30.0),
      radius: 250,
    );

    const Gradient gradiente = RadialGradient(
      colors: [
        Color(0xFF963594),
        Color(0xFF0092D0),
      ],
    );

    final lapiz = Paint()..shader = gradiente.createShader(rect);
// COLOR DE LAPIZ
    // lapiz.color = Color(0xFF615AAB);
    lapiz.color = Colors.red;
// RELLENAR O SOLO MANTENER LOS BORDES
    lapiz.style = PaintingStyle.fill; //fill,stroke
// GROSOR DEL LAPIZ
    lapiz.strokeWidth = 0;

// LUGAR DONDE APARECERÁ EL LAPIZ
    final path = Path();

// DIJUJAR CON EL PATH Y EL LAPIZ
    // path.moveTo(0, size.height * 0.5);
    path.lineTo(0, size.height * 0.90);
    path.lineTo(size.width * 0.09, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.163, size.height, size.width * 0.22, size.height * 0.90);
    path.lineTo(size.width, size.height * 0.90);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

// DIBUJAR EL PATH
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
