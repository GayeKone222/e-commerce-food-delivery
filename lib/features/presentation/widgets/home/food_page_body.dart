import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/core/utils/dimensions.dart';
import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/presentation/bloc/popular_products_bloc/popular_products_bloc.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';
import 'package:e_commerce/features/presentation/widgets/home/food_page_pageview.dart';
import 'package:e_commerce/features/presentation/widgets/home/food_page_popular_products_list.dart';
import 'package:e_commerce/features/presentation/widgets/home/main_pageview_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider
        BlocBuilder<PopularProductsBloc, PopularProductsState>(
          builder: (context, state) {
            if (state.status == AppStateStatus.loading) {
              return const CircularProgressIndicator.adaptive();
            }
            if (state.status == AppStateStatus.success) {
              return FoodPagePageView(
                currentPageValue: _currentPageValue,
                pageController: pageController,
                popularProducts: state.products!,
              );
            }
            if (state.status == AppStateStatus.failure) {
              return const Bigtext(text: "Failded to retrieve data");
            }
            return const SizedBox.shrink();
          },
        ),
        //dots
        BlocBuilder<PopularProductsBloc, PopularProductsState>(
          builder: (context, state) {
            return state.status == AppStateStatus.success
                ? DotsIndicator(
                    dotsCount: state.products?.length ?? 1,
                    position: _currentPageValue,
                    decorator: DotsDecorator(
                      activeColor: AppColors.mainColor,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  )
                : const SizedBox.shrink();
          },
        )
        //Popular
        ,
        SizedBox(
          height: 30.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 30.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Bigtext(text: "Recommended"),
              SizedBox(
                width: 10.w,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3.h),
                child: const Bigtext(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: const SmallText(text: "Food pairing")),
            ],
          ),
        )

        //List of food and images
        ,
        BlocBuilder<PopularProductsBloc, PopularProductsState>(
          builder: (context, state) {
            if (state.status == AppStateStatus.loading) {
              return const CircularProgressIndicator.adaptive();
            }
            if (state.status == AppStateStatus.success) {
              return PopularProductsList(popularProducts: state.products ?? []);
            }
            if (state.status == AppStateStatus.failure) {
              return const Bigtext(text: "Failded to retrieve data");
            }
            return const SizedBox.shrink();
          },
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
