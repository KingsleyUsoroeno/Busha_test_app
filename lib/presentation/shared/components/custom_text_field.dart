import 'package:busha_app/presentation/shared/components/text_view.dart';
import 'package:busha_app/presentation/themes/app_theme.dart';
import 'package:busha_app/core/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? labelText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? maxLength;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final bool isPasswordField;
  final TextAlign textAlign;
  final bool enabledTextFieldBorder;
  final bool? isFilled;
  final BorderRadius textFieldBorderRadius;
  final Color? filledColor;
  final double borderWidth, fontSize;
  final FocusNode? focusNode;
  final bool isOtpField;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.labelText,
    this.errorText,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength,
    this.isReadOnly = false,
    this.onTap,
    this.isPasswordField = false,
    this.textAlign = TextAlign.start,
    this.enabledTextFieldBorder = false,
    this.isFilled = true,
    this.textFieldBorderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.filledColor,
    this.borderWidth = 1.0,
    this.fontSize = 16.0,
    this.focusNode,
    this.isOtpField = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool get isPasswordField =>
      widget.isPasswordField && widget.label != null && widget.label!.toLowerCase().contains('password');

  bool get isEmailField => widget.label != null && widget.label!.toLowerCase().contains('email');

  bool get isPhoneNumberField => widget.label != null && widget.label!.toLowerCase().contains("phone");

  bool _obscureText = true;

  final inputFormatters = <TextInputFormatter>[];

  @override
  void initState() {
    if (isPasswordField || isEmailField || isPhoneNumberField) {
      inputFormatters.add(FilteringTextInputFormatter.deny(RegExp(r'\s')));
    }
    if (isPhoneNumberField) {
      AppLogger.debug("isPhoneNumberField");
      inputFormatters.addAll([
        FilteringTextInputFormatter.digitsOnly,
        //LengthLimitingTextInputFormatter(11),
      ]);
    }

    if (widget.isOtpField) {
      inputFormatters.addAll([
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(widget.maxLength),
      ]);
    }

    AppLogger.debug("isPassword field $isPasswordField");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InputDecorationTheme theme = Theme.of(context).inputDecorationTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          TextView(
            text: widget.label!,
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
        const SizedBox(height: 8),
        TextFormField(
          focusNode: widget.focusNode,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          readOnly: widget.isReadOnly,
          onTap: widget.onTap,
          onTapOutside: (PointerDownEvent event) {
            AppLogger.debug("onTapOutside called");
            FocusManager.instance.primaryFocus?.unfocus();
          },
          keyboardType: widget.keyboardType,
          obscureText: isPasswordField ? _obscureText : widget.obscureText,
          textInputAction: widget.textInputAction,
          //style: context.textTheme.titleMedium?.copyWith(fontSize: widget.fontSize),
          inputFormatters: inputFormatters,
          maxLength: widget.maxLength,
          //selectionControls: CustomTextSelectionControls(),
          decoration: InputDecoration(
            counterText: "",
            filled: widget.isFilled,
            hintText: widget.hintText,
            isDense: true,
            errorText: widget.errorText,
            fillColor: widget.filledColor ?? AppTheme.grey,
            hintStyle: GoogleFonts.inter(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.32),
            ),
            border: widget.enabledTextFieldBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      //color: !isDarkMode ? AppTheme.grey100 : AppTheme.faintBlack,
                      width: widget.borderWidth,
                    ),
                    borderRadius: widget.textFieldBorderRadius,
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: widget.textFieldBorderRadius,
                  ),
            focusedBorder: widget.enabledTextFieldBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      //color: !isDarkMode ? AppTheme.grey100 : AppTheme.faintBlack,
                      width: widget.borderWidth,
                    ),
                    borderRadius: widget.textFieldBorderRadius,
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: widget.textFieldBorderRadius,
                  ),
            enabledBorder: widget.enabledTextFieldBorder
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      //color: !isDarkMode ? AppTheme.grey100 : AppTheme.faintBlack,
                      width: widget.borderWidth,
                    ),
                    borderRadius: widget.textFieldBorderRadius,
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: widget.textFieldBorderRadius,
                  ),
            errorBorder: theme.errorBorder ??
                const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
            focusedErrorBorder: InputBorder.none,
            suffixIcon: isPasswordField
                ? IconButton(
                    icon: TextView(
                      text: !_obscureText ? "HIDE" : "SHOW",
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF5A5A5A),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: widget.suffixIcon,
                  ),
            contentPadding: EdgeInsets.only(
              top: widget.maxLines > 1 ? 40.0 : 12.0,
              left: 10,
              bottom: widget.prefixIcon != null || widget.suffixIcon != null ? 5.0 : 0.0,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: widget.prefixIcon,
                  )
                : null,
          ),
        )
      ],
    );
  }
}
