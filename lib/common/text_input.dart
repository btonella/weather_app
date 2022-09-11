import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/theme.dart';

Widget defaultTextField({
  required BuildContext context,
  required TextEditingController controller,
  required FocusNode focusNode,
  bool isWithError = false,
  bool isWithSuccess = false,
  String? hint,
  void Function(String)? onChanged,
  void Function()? onTap,
  EdgeInsets? padding,
  Widget? suffixIcon,
  Widget? prefixIcon,
  bool enabled = true,
  bool isObscureText = false,
  List<TextInputFormatter>? inputFormatters,
  int? maxLength,
  int maxLines = 1,
  TextInputType? keyboardType,
  TextStyle? hintStyle,
}) {
  AppColors appColors = getAppColors();
  return Container(
    margin: padding,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15),
          decoration: ShapeDecoration(
            color: appColors.background(),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: appColors.grey()),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Center(
            child: TextFormField(
              cursorColor: appColors.grey(),
              enabled: enabled,
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              focusNode: focusNode,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: hint,
                hintStyle: hintStyle ?? defaultTextTheme.subtitle1?.copyWith(fontWeight: FontWeight.w400),
                labelStyle: defaultTextTheme.subtitle2,
                border: InputBorder.none,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              ),
              inputFormatters: inputFormatters,
              maxLength: maxLength,
              maxLines: maxLines,
              obscureText: isObscureText,
              // style: defaultTextTheme.subtitle1?.copyWith(fontWeight: FontWeight.w400, color: appColors.body()),
              keyboardType: keyboardType,
            ),
          ),
        ),
      ],
    ),
  );
}
