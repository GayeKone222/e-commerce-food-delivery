import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/widgets/common/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemsBadge extends StatelessWidget {
  const CartItemsBadge({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductToCartCubit, Map<int, CartEntity>>(
      builder: (context, state) {
        int? totalItems =
            context.read<AddProductToCartCubit>().countTotalItems(map: state);
        return Stack(
          children: [
            child,
            if (totalItems != 0)
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.mainColor),
                    child: SmallText(
                      text: "$totalItems",
                      color: Colors.white,
                    ),
                  ))
          ],
        );
      },
    );
  }
}
