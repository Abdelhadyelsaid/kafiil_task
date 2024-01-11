import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final double? height;
  final Color? background;
  final Color borderColor;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;
  final bool isUpperCase;
  final double radius;
  final Function()? function;
  final String text;
  final Color color;


  const DefaultButton({
    Key? key,
    this.height,
    this.width = double.infinity,
    this.background,
    this.textColor = Colors.white,
    this.textSize = 12,
    this.textWeight = FontWeight.w400,
    this.isUpperCase = true,
    this.radius = 10,
    required this.function,
    required this.text,
    this.color=  const Color(0xFF1DBF73),
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: color,

        border: Border.all(color: borderColor),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize.sp,
            fontWeight: textWeight,
            fontFamily: 'Almarai',
          ),
        ),
      ),
    );
  }
}
