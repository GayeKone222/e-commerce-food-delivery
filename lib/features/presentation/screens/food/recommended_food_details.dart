import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/widgets/common/app_icon.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/food/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedFoodDetails extends StatelessWidget {
  const RecommendedFoodDetails({Key? key, required this.popularProduct})
      : super(key: key);

  final ProductEntity popularProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            AppIcon(
              icon: Icons.clear,
              onTap: () => BlocProvider.of<NavigatorBloc>(context).add(Pop()),
            ),
            AppIcon(icon: Icons.shopping_cart_outlined),
          ]),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.h),
            child: Container(
                width: double.maxFinite,
                // margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                    child: Bigtext(
                  text: popularProduct.name,
                  size: 26.h,
                ))),
          ),
          pinned: true,
          backgroundColor: AppColors.yellowColor,
          expandedHeight: 300.h,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              popularProduct.img,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: ExpandableTextWidget(text: popularProduct.description),
              ),
            ],
          ),
        )
      ]),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  iconSize: 24,
                  icon: Icons.remove,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                ),
                Bigtext(
                  text: "\$${popularProduct.price} " + " X " + " 0",
                  color: AppColors.mainBlackColor,
                  size: 26,
                ),
                AppIcon(
                  iconSize: 24,
                  icon: Icons.add,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          Container(
            height: 120.h,
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r)),
                color: AppColors.buttonBackgroundColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white),
                  child: const Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.mainColor),
                  child: Bigtext(
                    text: "\$ ${popularProduct.price} | Add to cart",
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
