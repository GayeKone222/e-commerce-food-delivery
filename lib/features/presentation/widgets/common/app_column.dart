import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/icon_and_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColumn extends StatelessWidget {
  const AppColumn({Key? key, required this.product}) : super(key: key);

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
          Bigtext(text: product.name, size: 26.h,),
          const Spacer(),
        // SizedBox(
        //   height: 10.h,
        // ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => const Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                      )),
            ),
            SizedBox(
              width: 10.w,
            ),
            const SmallText(text: "4.5"),
            SizedBox(
              width: 10.w,
            ),
            const SmallText(text: "1287"),
            SizedBox(
              width: 10.w,
            ),
            const SmallText(text: "comments"),
          ],
        ),
        // SizedBox(
        //   height: 20.h,
        // ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7Km",
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "32min",
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
