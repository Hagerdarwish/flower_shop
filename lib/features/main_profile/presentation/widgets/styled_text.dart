import 'package:flower_shop/features/main_profile/domain/models/text_style_model.dart';
import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  final TextStyleModel? style;

  const StyledText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: style?.backgroundColor != null
          ? Color(int.parse(style!.backgroundColor!.replaceFirst('#', '0xff')))
          : null,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: Text(
        text,
        textAlign: _getAlign(),
        style: TextStyle(
          fontSize: style?.fontSize,
          fontWeight: style?.fontWeight == 'bold'
              ? FontWeight.bold
              : FontWeight.normal,
          color: style?.color != null
              ? Color(int.parse(style!.color!.replaceFirst('#', '0xff')))
              : null,
        ),
      ),
    );
  }

  TextAlign _getAlign() {
    if (style?.textAlign is String) {
      switch (style!.textAlign) {
        case 'center':
          return TextAlign.center;
        case 'right':
          return TextAlign.right;
        default:
          return TextAlign.left;
      }
    } else if (style?.textAlign is Map) {
      final map = style!.textAlign as Map;
      return map['en'] == 'center'
          ? TextAlign.center
          : map['en'] == 'right'
          ? TextAlign.right
          : TextAlign.left;
    }
    return TextAlign.left;
  }
}
