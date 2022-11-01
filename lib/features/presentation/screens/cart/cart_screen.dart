import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/cart_history_cubit/cart_history_cubit.dart';
import 'package:e_commerce/features/presentation/widgets/cart/cart_list_items.dart';
import 'package:e_commerce/features/presentation/widgets/common/app_icon.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/cart_items_badge.dart';
import 'package:e_commerce/features/presentation/widgets/common/no_data_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                  top: 60.h,
                  left: 20.w,
                  right: 20.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppIcon(
                        onTap: () =>
                            BlocProvider.of<NavigatorBloc>(context).add(Pop()),
                        icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: 24,
                      ),
                      SizedBox(
                        width: 100.w,
                      ),
                      AppIcon(
                        onTap: () => BlocProvider.of<NavigatorBloc>(context)
                            .add(const PushNamed(route: Routes.MainRoute)),
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: 24,
                      ),
                      const CartItemsBadge(
                        child: AppIcon(
                          icon: Icons.shopping_cart,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          iconSize: 24,
                        ),
                      )
                    ],
                  )),
              Positioned(
                  top: 100.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 0,
                  child:
                      BlocBuilder<AddProductToCartCubit, Map<int, CartEntity>>(
                    builder: (context, state) {
                      return state.isEmpty
                          ? const Center(
                              child: NoDataPage(text: "Your Cart is Empty!"),
                            )
                          : CartItemsList(
                              productsAddedInCart: state.values.toList());
                    },
                  ))
            ],
          ),
          bottomNavigationBar: Builder(builder: (context) {
            return BlocBuilder<AddProductToCartCubit, Map<int, CartEntity>>(
              builder: (context, state) {
                return Container(
                  height: 120.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r)),
                      color: AppColors.buttonBackgroundColor),
                  child: state.isEmpty
                      ? const SizedBox.shrink()
                      : Row(
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
                                  SizedBox(
                                    width: 5.h,
                                  ),
                                  Bigtext(
                                      text:
                                          "\$ ${context.read<AddProductToCartCubit>().totalAmount(map: state)}"),
                                  SizedBox(
                                    width: 5.h,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<CartHistoryCubit>().update(
                                    order: CartHistoryEntity(
                                        cartEntities: state.values.toList(),
                                        time: DateTime.now().toString()));

                                // delete stored cart items
                                context
                                    .read<AddProductToCartCubit>()
                                    .clearCartItems();

                                //navigate
                                // BlocProvider.of<NavigatorBloc>(context)
                                //     .add(const PushNamed(
                                //   route: Routes.CartHistoryRoute,
                                // ));

                                BlocProvider.of<NavigatorBloc>(context)
                                    .add(const PushNamed(
                                  route: Routes.MainRoute,
                                ));
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 20.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: AppColors.mainColor),
                                  child: const Bigtext(
                                    text: "Check out",
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                );
              },
            );
          })),
    );
  }
}
