import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerGenerator {
  static Future<BitmapDescriptor> createCustomMarker({
    required String title,
    required IconData iconData,
    Color backgroundColor = const Color(0xffE91E63),
    Color iconBackgroundColor = Colors.white,
    Color textColor = Colors.white,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    const double baseHeight = 50;
    const double pointerHeight = 10.0;
    final double iconBoxSize = baseHeight - 16;
    const double paddingRight = 14.0;
    const double paddingLeft = 8.0;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    textPainter.text = TextSpan(
      text: title,
      style: TextStyle(
        fontSize: 18,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
    textPainter.layout();

    final double textWidth = textPainter.width;
    final double textHeight = textPainter.height;
    final double width =
        paddingLeft + iconBoxSize + 10.0 + textWidth + paddingRight;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, width, baseHeight),
          const Radius.circular(baseHeight / 2),
        ),
      );
    path.moveTo(width / 2 - 7, baseHeight);
    path.lineTo(width / 2, baseHeight + pointerHeight);
    path.lineTo(width / 2 + 7, baseHeight);
    canvas.drawPath(path, Paint()..color = backgroundColor);

    final double iconBoxLeft = paddingLeft;
    final double iconBoxTop = (baseHeight - iconBoxSize) / 2;
    canvas.drawCircle(
      Offset(iconBoxLeft + iconBoxSize / 2, iconBoxTop + iconBoxSize / 2),
      iconBoxSize / 2,
      Paint()..color = iconBackgroundColor,
    );

    final TextPainter iconPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    iconPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontSize: iconBoxSize * 0.65,
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
        color: backgroundColor,
      ),
    );
    iconPainter.layout();
    iconPainter.paint(
      canvas,
      Offset(
        iconBoxLeft + (iconBoxSize - iconPainter.width) / 2,
        iconBoxTop + (iconBoxSize - iconPainter.height) / 2,
      ),
    );

    textPainter.paint(
      canvas,
      Offset(iconBoxLeft + iconBoxSize + 10.0, (baseHeight - textHeight) / 2),
    );

    final ui.Image image = await pictureRecorder.endRecording().toImage(
      width.toInt(),
      (baseHeight + pointerHeight).toInt(),
    );
    final data = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
