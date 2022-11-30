import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/icon_and_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularProductsListItem extends StatelessWidget {
  const PopularProductsListItem({Key? key, required this.popularProduct})
      : super(key: key);

  final ProductEntity popularProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 10.h),
      child: Row(
        children: [
          Container(
            height: 120.h,
            width: 120.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white30,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        ApiConstant.uploadsUrl + popularProduct.img))),
          ),
          Expanded(
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Bigtext(text: "Nutritious fruit meal in china"),
                  SizedBox(
                    height: 10.h,
                  ),
                  const SmallText(text: "With chinese chracteristics"),
                  SizedBox(
                    height: 10.h,
                  ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
