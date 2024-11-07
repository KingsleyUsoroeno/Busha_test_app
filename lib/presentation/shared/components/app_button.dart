import 'package:busha_app/presentation/shared/components/text_view.dart';
import 'package:busha_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Widget? child;
  final double width, height;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final Color? bgColor, textColor;
  final double fontSize;

  AppButton({
    super.key,
    this.title,
    this.width = double.infinity,
    this.height = 48,
    this.onPressed,
    this.isEnabled = true,
    this.child,
    this.bgColor = AppTheme.colorAccent,
    this.textColor,
    this.fontSize = 16,
  }) {
    if (child == null) {
      assert(title != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: child ??
            Center(
              child: TextView(
                text: title!,
                align: TextAlign.center,
                color: textColor ?? Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
      ),
    );
  }
}
