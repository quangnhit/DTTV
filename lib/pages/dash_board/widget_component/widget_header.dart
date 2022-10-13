import 'package:dttv/import.dart';

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.0757143);
    path0.lineTo(size.width * 0.2516667, size.height * 0.3571429);
    path0.lineTo(size.width * 0.2683333, size.height * 0.3942857);
    path0.lineTo(size.width * 0.2908333, size.height * 0.4185714);
    path0.lineTo(size.width * 0.3191667, size.height * 0.4100000);
    path0.lineTo(size.width * 0.5241667, size.height * 0.3728571);
    path0.lineTo(size.width * 0.5725000, size.height * 0.3314286);
    path0.lineTo(size.width * 0.5775000, size.height * 0.3057143);
    path0.lineTo(size.width * 0.5800000, size.height * 0.0714286);
    path0.lineTo(size.height, size.width);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
