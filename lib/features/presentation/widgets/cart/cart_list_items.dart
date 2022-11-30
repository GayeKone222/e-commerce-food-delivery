import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/widgets/cart/cart_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({Key? key, required this.productsAddedInCart})
      : super(key: key);

  final List<CartEntity> productsAddedInCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      //  color: Colors.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            itemCount: productsAddedInCart.length,
            itemBuilder: (_, int index) => GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigatorBloc>(context).add(PushNamed(
                        route: productsAddedInCart[index]
                                    .productEntity
                                    .isRecommended ??
                                false
                            ? Routes.RecommendedFoodDetails
                            : Routes.PopularFoodDetails,
                        objectParam: productsAddedInCart[index].productEntity));
                  },
                  child: CartProductItem(
                    product: productsAddedInCart[index],
                  ),
                )),
      ),
    );
  }
}
