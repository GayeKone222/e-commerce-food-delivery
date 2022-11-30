import 'dart:io';

import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/dependency_injection.dart/injections.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/core/utils/dimensions.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/popular_food_update_quantity_cubit/popular_food_update_quantity_cubit.dart';
import 'package:e_commerce/features/presentation/widgets/common/app_column.dart';
import 'package:e_commerce/features/presentation/widgets/common/app_icon.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/cart_items_badge.dart';
import 'package:e_commerce/features/presentation/widgets/food/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularFoodDetails extends StatelessWidget {
  const PopularFoodDetails({Key? key, required this.popularProduct})
      : super(key: key);

  final ProductEntity popularProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PopularFoodUpdateQuantityCubit>()
        ..init(productEntity: popularProduct),
      lazy: false,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(fit: StackFit.expand, children: [
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 350.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            ApiConstant.uploadsUrl + popularProduct.img),
                      ),
                    ),
                  )),
              Positioned(
                  top: 45.h,
                  left: 20.w,
                  right: 20.w,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppIcon(
                          onTap: () => BlocProvider.of<NavigatorBloc>(context)
                              .add(Pop()),
                          icon: Icons.arrow_back_ios,
                        ),
                        CartItemsBadge(
                          child: AppIcon(
                            onTap: () => BlocProvider.of<NavigatorBloc>(context)
                                .add(const PushNamed(route: Routes.CartRoute)),
                            icon: Icons.shopping_cart_outlined,
                          ),
                        )
                      ])),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 350.h - 20.h,
                  child: Container(
                      padding:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r)),
                          color: Colors.white),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: Dimensions.pageViewTextContainer,
                              child: AppColumn(
                                product: popularProduct,
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Bigtext(text: "Introduce"),
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                  child: ExpandableTextWidget(
                                      text: popularProduct.description)))
                        ],
                      )))
            ]),
            bottomNavigationBar: Builder(builder: (context) {
              return Container(
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
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<PopularFoodUpdateQuantityCubit>()
                                  .decrement();
                            },
                            child: const Icon(
                              Icons.remove,
                              color: AppColors.signColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          BlocBuilder<PopularFoodUpdateQuantityCubit, int>(
                            builder: (context, state) {
                              return Bigtext(text: state.toString());
                            },
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<PopularFoodUpdateQuantityCubit>()
                                  .increment();
                            },
                            child: const Icon(
                              Icons.add,
                              color: AppColors.signColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    BlocBuilder<PopularFoodUpdateQuantityCubit, int>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<AddProductToCartCubit>().addItem(
                                product: popularProduct, quatity: state);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 20.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: AppColors.mainColor),
                            child: BlocBuilder<PopularFoodUpdateQuantityCubit,
                                int>(
                              builder: (context, state) {
                                return Bigtext(
                                  text:
                                      "\$ ${popularProduct.price * state} | Add to cart",
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            })),
      ),
    );
  }
}
