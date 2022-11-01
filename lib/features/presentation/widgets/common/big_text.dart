import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bigtext extends StatelessWidget {
  const Bigtext(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.overFlow = TextOverflow.ellipsis,
      this.size = 20})
      : super(key: key);

  final Color? color;
  final String text;
  final TextOverflow overFlow;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: "Roboto",
          fontSize: size.sp),
    );
  }
}
