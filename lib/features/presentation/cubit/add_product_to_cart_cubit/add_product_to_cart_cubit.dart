import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/domain/usecases/stored_cart_items_usecases/stored_cart_items.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductToCartCubit extends Cubit<Map<int, CartEntity>> {
  final CartUsecases cartUsecases;
  AddProductToCartCubit({required this.cartUsecases}) : super({});

  void init() {
    print('AddProductToCartCubit init');
    final data = cartUsecases.get();
    data.fold((l) => print("error left AddProductToCartCubit "), (r) {
      print("right : $r");
      emit({for (var e in r) e.id: e});
    });
  }

  void addMultipleItems({required List<CartEntity> cartItems}) {
    Map<int, CartEntity> items = {};

    for (var cartItem in cartItems) {
      items.putIfAbsent(cartItem.id, () => cartItem);
    }

    cartUsecases.store(items: items.values.toList());

    emit(items);
  }

  void addItem({required ProductEntity product, required int quatity}) {
    Map<int, CartEntity> items = Map.from(state);
    if (items.containsKey(product.id)) {
      items.update(
          product.id,
          (value) => value.copyWith(
              quatity: quatity, time: DateTime.now().toString()));
    } else {
      items.putIfAbsent(
          product.id,
          () => CartEntity(
              id: product.id,
              productEntity: product,
              name: product.name,
              description: product.description,
              price: product.price,
              img: product.img,
              quatity: quatity,
              isExist: true,
              time: DateTime.now().toString()));
    }
    // items.forEach((key, value) {
    //   if (kDebugMode) {
    //     print("product id : $key : quantity = ${value.quatity}");
    //   }
    // });
    //store data locally
    cartUsecases.store(items: items.values.toList());

    emit(items);

    //  print("cart items : $state");
  }

  void updateItem({required CartEntity item, required int quatity}) {
    Map<int, CartEntity> items = Map.from(state);
    if (items.containsKey(item.id)) {
      if (quatity == 0) {
        items.remove(item.id);
      } else {
        items.update(
            item.id,
            (value) => value.copyWith(
                quatity: quatity, time: DateTime.now().toString()));
      }

      //store data locally
      cartUsecases.store(items: items.values.toList());

      emit(items);
    }
  }

  void clearCartItems() {
    final data = cartUsecases.clear();
    data.fold((l) => print("error left clearCartItems "), (r) {
      emit({});
    });
  }

  int totalAmount({required Map<int, CartEntity> map}) {
    int total = 0;
    map.forEach((key, value) {
      total += value.price * value.quatity!;
    });

    return total;
  }

  int countTotalItems({required Map<int, CartEntity> map}) {
    int? totalItems = map.isNotEmpty
        ? map.values
            .map((e) => e.quatity)
            .reduce((value, element) => value! + element!)
        : 0;

    return totalItems ?? 0;
  }
}
