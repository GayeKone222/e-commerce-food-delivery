import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/core/utils/dimensions.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainFootPageHeader extends StatefulWidget {
  const MainFootPageHeader({Key? key}) : super(key: key);

  @override
  State<MainFootPageHeader> createState() => _MainFootPageHeaderState();
}

class _MainFootPageHeaderState extends State<MainFootPageHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 45.h, bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Bigtext(
              text: "Bangladesh",
              color: AppColors.mainColor,
            ),
            Row(
              children: [
                const SmallText(
                  text: "Narsingdi",
                  color: Colors.black54,
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  size: Dimensions.iconSize,
                ),
              ],
            ),
          ],
        ),
        Center(
          child: Container(
            width: 45.h,
            height: 45.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColors.mainColor),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: Dimensions.iconSize,
            ),
          ),
        )
      ]),
    );
  }
}
