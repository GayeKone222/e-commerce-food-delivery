import 'package:e_commerce/core/utils/dimensions.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/widgets/common/app_column.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPageViewItem extends StatelessWidget {
  const MainPageViewItem(
      {Key? key,
      required this.index,
      required this.currentPageValue,
      this.scaleFactor = 0.8,
      this.height = 220, required this.popularProduct})
      : super(key: key);
  final int index;
  final double currentPageValue;
  final double scaleFactor;
  final double height;
    final ProductEntity popularProduct;

  @override
  Widget build(BuildContext context) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: height,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: const Color(0xFF69c5df),
              image:   DecorationImage(
                  image: AssetImage(popularProduct.img),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: Dimensions.pageViewTextContainer,
                  padding: EdgeInsets.symmetric(horizontal: 10.w)
                      .copyWith(top: 10.h),
                  margin: EdgeInsets.symmetric(horizontal: 30.w)
                      .copyWith(bottom: 30.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFFe8e8e8),
                          blurRadius: 5.0.r,
                          offset: const Offset(0, 5)),
                      const BoxShadow(
                          color: Colors.white,
                          //  blurRadius: 5.0,
                          offset: Offset(-5, 0)),
                      const BoxShadow(
                          color: Colors.white,
                          //  blurRadius: 5.0,
                          offset: Offset(5, 0)),
                    ],
                    color: Colors.white,
                  ),
                  child: const AppColumn())),
        ],
      ),
    );
  }
}
