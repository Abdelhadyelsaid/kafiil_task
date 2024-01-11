import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  double? height,
  int maxLines = 1,
  double? width,
  bool noBorder = false,
  bool readOnly = false,
  double? textSize,
  String? title,
  SvgPicture? suffix,
  SvgPicture? prefix,
  onSubmit,
  onChanged,
  onTap,
  bool isPassword = false,
  required String? Function(String?)? validator,
  required String hint,
  bool? filled,
  bool isClickable = true,
  Color? suffixColor,
  Function? suffixPressed,
  Function? prefixPressed,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              )
            : const SizedBox(),
        Container(
          width: width ?? .9.sw,
          height: height,
          child: TextFormField(
            readOnly: readOnly,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: textSize ?? 14.sp,
              color: Colors.black,
            ),
            controller: controller,
            keyboardType: type,
            maxLines: maxLines,
            obscureText: isPassword,
            enabled: isClickable = true,
            onFieldSubmitted: onSubmit,
            onChanged: onChanged,
            onTap: onTap,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.grey)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.white)),
              hintText: hint,
              icon: prefix != null
                  ? IconButton(
                      onPressed: () {
                        prefixPressed!();
                      },
                      icon: prefix)
                  : null,
              suffixIcon: suffix != null
                  ? IconButton(
                      onPressed: () {
                        suffixPressed!();
                      },
                      icon: suffix)
                  : null,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );

Widget defaultTextButton({
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextButton(
          onPressed: () {
            function();
          },
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF1DBF73)),
          )),
    );
