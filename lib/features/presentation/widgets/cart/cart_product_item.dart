import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({Key? key, required this.product}) : super(key: key);

  final CartEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.maxFinite,
      // color: Colors.blue,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Container(
            width: 100.h,
            height: 100.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(
                            ApiConstant.uploadsUrl +product.img))),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
              child: SizedBox(
            height: 100.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Bigtext(
                  text: product.name,
                  color: Colors.black54,
                ),
                const SmallText(text: "Spicy"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bigtext(
                      text: "\$ ${product.price}.0",
                      color: Colors.redAccent,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (product.quatity != 0) {
                                context
                                    .read<AddProductToCartCubit>()
                                    .updateItem(
                                        item: product,
                                        quatity: product.quatity! - 1);
                              }
                            },
                            child: const Icon(
                              Icons.remove,
                              color: AppColors.signColor,
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Bigtext(text: product.quatity.toString()),
                          SizedBox(
                            width: 5.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<AddProductToCartCubit>().updateItem(
                                  item: product, quatity: product.quatity! + 1);
                            },
                            child: const Icon(
                              Icons.add,
                              color: AppColors.signColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
