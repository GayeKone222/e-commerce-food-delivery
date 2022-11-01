import 'dart:async';

import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularFoodUpdateQuantityCubit extends Cubit<int> {
  PopularFoodUpdateQuantityCubit({required this.addProductToCartCubit})
      : super(1);

  final AddProductToCartCubit addProductToCartCubit;

  StreamSubscription<Map<int, CartEntity>>? addProductToCartCubitStreamSub;

  @override
  Future<void> close() {
    addProductToCartCubitStreamSub?.cancel();
    return super.close();
  }

  void init({required ProductEntity productEntity}) {
    //get the current stored quantity of the product in the cart
    CartEntity? c = addProductToCartCubit.state[productEntity.id];
    if (c != null) {
      emit(c.quatity!);
    }

    //listen to changes coming from the cart page
    addProductToCartCubitStreamSub =
        addProductToCartCubit.stream.listen((newState) {
      CartEntity? c = newState[productEntity.id];
      if (c != null) {
        emit(c.quatity!);
      }
    });
  }

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state > 1 ? state - 1 : 1);
  }
}
