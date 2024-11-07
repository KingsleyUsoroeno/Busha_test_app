import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final GlobalKey? textKey;
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? align;
  final Color? color;
  final double? fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final int? maxLines;
  final TextStyle? style;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;

  const TextView({
    super.key,
    this.textKey,
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.align = TextAlign.left,
    this.color,
    this.onTap,
    this.fontSize = 16.0,
    this.lineHeight,
    this.style,
    this.maxLines,
    this.fontWeight = FontWeight.w600,
    this.decoration,
    this.fontStyle = FontStyle.normal,
    this.decorationStyle,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        key: textKey,
        style: style?.copyWith(inherit: true) ??
            GoogleFonts.inter(
              color: color,
              decoration: decoration,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontStyle: fontStyle,
              height: lineHeight,
              decorationStyle: decorationStyle,
              decorationColor: decorationColor,
            ).copyWith(inherit: true),
        textAlign: align,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}
