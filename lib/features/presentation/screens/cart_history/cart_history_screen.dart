import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/cart_history_cubit/cart_history_cubit.dart';
import 'package:e_commerce/features/presentation/widgets/common/app_icon.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/no_data_page.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              color: AppColors.mainColor,
              height: 100.h,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 45.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Bigtext(
                    text: "Cart History",
                    color: Colors.white,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.mainColor,
                  )
                ],
              )),
          Expanded(
            child: BlocBuilder<CartHistoryCubit, List<CartHistoryEntity>>(
              builder: (context, state) {
                return 
                state.isEmpty
                          ? const Center(
                              child: NoDataPage(text: "You didn't buy anything so far!", imagePath: "assets/image/empty_box.png",),
                            ):
                Container(
                  margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                        itemCount: state.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (() {
                                  DateTime parseDate =
                                      DateFormat("yyyy-MM-dd HH:mm:ss")
                                          .parse(state[index].time);
                                  var outputFormat =
                                      DateFormat("MM/dd/yyyy hh:mm a");
                                  var outputDate =
                                      outputFormat.format(parseDate);
                                  return Bigtext(text: outputDate);
                                }()),
                                //  Bigtext(text: state[index].time),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 80.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                          children: List.generate(
                                              state[index].cartEntities.length,
                                              (index2) => index2 <= 2
                                                  ? Container(
                                                      height: 80.h,
                                                      width: 80.h,
                                                      margin: EdgeInsets.only(
                                                          right: 5.w),
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  state[index]
                                                                      .cartEntities[
                                                                          index2]
                                                                      .img))),
                                                    )
                                                  : const SizedBox.shrink())),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SmallText(text: "Total"),
                                            Bigtext(
                                              text:
                                                  "${state[index].cartEntities.length} Items",
                                              color: AppColors.titleColor,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                //set new cart items
                                                BlocProvider.of<
                                                            AddProductToCartCubit>(
                                                        context)
                                                    .addMultipleItems(
                                                        cartItems: state[index]
                                                            .cartEntities);


                                                   //navigate to cart screen
                                                BlocProvider.of<NavigatorBloc>(
                                                        context)
                                                    .add(const PushNamed(
                                                  route: Routes.MainRoute,
                                                ));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.r),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor)),
                                                child: const SmallText(
                                                  text: "one more",
                                                  color: AppColors.mainColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
