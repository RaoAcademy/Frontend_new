import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:EdTestz/core/theme/theme.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/utli/validations.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.labelText,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.autoValidate = false,
    this.inputType = TextInputType.text,
    this.initialValue,
    this.formKey,
    this.controller,
    this.validator = LoopsValidation.none,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.hintText,
    this.maxLength,
    this.borderAround = false,
    this.obscureText = false,
    this.counterText,
    this.smallSize = false,
    this.inputFormatters,
    this.requiredField = true,
    this.lightTheme = false,
    this.borderColor,
    this.textStyle,
    this.textCapitalization,
  }) : super(key: key);
  final String? labelText;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function(String)? onSaved;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? enabled;
  final bool? obscureText;
  final bool? autoValidate;
  final String? initialValue;
  final TextInputType? inputType;
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final LoopsValidation validator;
  final num? maxLines;
  final num? maxLength;
  final TextStyle? textStyle;
  final String? counterText;
  final TextAlign? textAlign;
  final bool? smallSize;
  final bool borderAround;
   final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool? requiredField; // to check in validation by default it is true
  final bool? lightTheme;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Center(
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom:100),
                textCapitalization:
                    textCapitalization ?? TextCapitalization.none,
                inputFormatters: inputFormatters,
                enabled: enabled,
                obscureText: obscureText ?? false,
                // autovalidateMode: autoValidate
                //     ? AutovalidateMode.onUserInteraction
                //     : AutovalidateMode.disabled,
                // ignore: prefer_if_null_operators
                style: textStyle != null
                    ? textStyle
                    : lightTheme!
                        ? appTheme.textTheme.titleLarge!.copyWith(
                            color: LoopsColors.textColor,
                          )
                        : appTheme.textTheme.titleLarge!.copyWith(
                            color: lightTheme!
                                ? LoopsColors.colorWhite
                                : LoopsColors.textColor,
                          ),
                keyboardType: inputType,
                cursorColor: lightTheme!
                    ? LoopsColors.colorWhite
                    : LoopsColors.textColor,
                initialValue: initialValue,
                maxLines: maxLines?.toInt() ?? 1,
                minLines: 1,
                maxLength: maxLength?.toInt() ?? 256,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(

                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                      color: LoopsColors.textColor.withOpacity(0.8),
                      fontSize: 13.sp),
                  fillColor: lightTheme!
                      ? LoopsColors.colorWhite
                      : LoopsColors.textColor,
                  filled: lightTheme,
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  prefixIconColor: LoopsColors.tertiaryColor,
                  suffixIconColor: LoopsColors.tertiaryColor,
                  hintText: hintText,
                  counterText: counterText ?? '',
                  contentPadding: smallSize == true
                      ? EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h)
                      : null,
                  errorStyle: smallSize == true
                      ? const TextStyle(
                          color: Colors.transparent, fontSize: 0, height: 0)
                      : null,

                  /// When TextField is not active,
                  enabledBorder: borderAround
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: lightTheme!
                                ? LoopsColors.colorWhite
                                : LoopsColors.textColor.withOpacity(0.5),
                            width: 0.6.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: lightTheme!
                                ? LoopsColors.colorWhite
                                : borderColor == null ? LoopsColors.textColor: borderColor!,
                            width: 1.4.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        ),

                  disabledBorder: borderAround
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: lightTheme!
                                ? LoopsColors.colorWhite
                                : LoopsColors.textColor.withOpacity(0.5),
                            width: 0.5.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: lightTheme!
                                ? LoopsColors.colorWhite
                                : LoopsColors.textColor.withOpacity(0.5),
                            width: 0.5.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        ),

                  /// When TextField is active.
                  focusedBorder: borderAround
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: LoopsColors.secondaryColor,
                            width: 0.8.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: LoopsColors.secondaryColor,
                            width: 0.8.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        ),
                  errorBorder: borderAround
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: LoopsColors.colorRed,
                            width: 0.8.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: LoopsColors.colorRed,
                            width: 0.8.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        ),
                  focusedErrorBorder: borderAround
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: LoopsColors.colorRed,
                            width: 0.8.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        )
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: LoopsColors.colorRed,
                            width: 0.8.w,
                          ),
                          borderRadius: BorderRadius.circular(24.sp),
                        ),
                  isDense: true,
                  labelText: labelText,
                  labelStyle: appTheme.textTheme.titleLarge!.copyWith(
                      color: lightTheme!
                          ? LoopsColors.textColor
                          : LoopsColors
                              .textColor, // TODO: Changed this color to LoopsColors.colorGrey.withOpacity(0.5),
                      letterSpacing: 1.sp,
                      fontSize: 15.sp),
                ),
                focusNode: focusNode,
                textAlign: textAlign ?? TextAlign.start,
                controller: controller,
                onChanged: onChanged,
                validator: (value) => Validations.validate(
                    type: validator,
                    value: value,
                    requiredField: requiredField),
                // onSaved: onSaved ?? (val){},
                onEditingComplete: onEditingComplete,
                onFieldSubmitted: onFieldSubmitted,
                readOnly: readOnly ?? false,
                onTap: onTap,
                // inputFormatters: getFormatters(),
              ),
            ),
          ),
        ),
        if (!smallSize!) SizedBox(height: 8.h),
      ],
    );
  }

  // List<TextInputFormatter> getFormatters() {
  //   final List<TextInputFormatter> finalInputFormatters = [];
  //   if (validator != null) {
  //     if (validator == CustomValidation.numericValue) {
  //       finalInputFormatters.add(DecimalTextInputFormatter(decimalRange: 2));
  //     } else if (validator == CustomValidation.price) {
  //       finalInputFormatters.add(DecimalTextInputFormatter(decimalRange: 2));
  //     }
  //   }

  //   finalInputFormatters.addAll(inputFormatters);

  //   return finalInputFormatters;
  // }
}
