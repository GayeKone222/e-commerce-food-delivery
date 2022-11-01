
import 'package:e_commerce/core/utils/dimensions.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget(
      {Key? key,
      required this.text,
      required this.icon,
      
      required this.iconColor})
      : super(key: key);

  final String text;
  final IconData icon;
  
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize,
        ),
          SizedBox(
          width: 5.w,
        ),
        SmallText(
          text: text,
           
        )
      ],
    );
  }
}
