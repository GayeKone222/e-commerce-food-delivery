import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
      {Key? key,
      required this.icon,
      this.iconColor = const Color(0xFF756d54),
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.size = 40,
      this.iconSize = 16,
      this.onTap})
      : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap??(){},
      child: Container(
        height: size.h,
        width: size.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.h / 2),
            color: backgroundColor),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize.h,
          ),
        ),
      ),
    );
  }
}
