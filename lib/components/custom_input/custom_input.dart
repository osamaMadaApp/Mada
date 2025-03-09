import 'package:flutter/services.dart';

import '../../general_exports.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    this.fillColor = Colors.white,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.borderColor,
    this.validator,
    this.initialValue,
    this.hintStyle,
    this.onFieldSubmitted,
    this.enabled = true,
    this.contentHorizontalPadding,
    this.contentVerticalPadding,
    this.maxLines,
    this.minLines,
    this.textColor,
    this.inputFormatters,
    this.focusNode,
  });

  final String? hint;
  final int? textColor;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color fillColor;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function? onChange;
  final Function? onFieldSubmitted;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextStyle? hintStyle;
  final bool? enabled;
  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      cursorColor: FlutterMadaTheme.of(context).primary,
      initialValue: initialValue,
      onChanged: (String value) {
        onChange?.call(value);
      },
      onFieldSubmitted: (String value) {
        onFieldSubmitted?.call(value);
      },
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: textColor != null ? Color(textColor!) : Colors.black,
          ),
      controller: controller,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      enabled: enabled,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hint,
        hintStyle: hintStyle,
        contentPadding: EdgeInsets.symmetric(
          horizontal: contentHorizontalPadding ?? 8.w,
          vertical: contentVerticalPadding ?? 16.h,
        ),
        fillColor: fillColor,
        filled: true,
        enabledBorder: _getInputBorder(context),
        disabledBorder: _getInputBorder(context),
        focusedBorder: _getInputBorder(context),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  InputBorder _getInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? FlutterMadaTheme.of(context).colorE1E1E1,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
    );
  }
}
