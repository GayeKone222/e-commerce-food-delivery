import 'package:e_commerce/features/domain/entities/cart_history_entity.dart';
import 'package:e_commerce/features/domain/usecases/cart_history_usecases/cart_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartHistoryCubit extends Cubit<List<CartHistoryEntity>> {
  final CartHistoryUsecases cartHistoryUsecases;
  CartHistoryCubit({required this.cartHistoryUsecases}) : super([]);

  void init() {
    print('CartHistoryCubit init');
    final data = cartHistoryUsecases.get();
    data.fold((l) => print("error left CartHistoryCubit "), (r) {
      print("right : $r");
      emit(r);
    });
  }

  void update({required CartHistoryEntity order}) {
    // store new data
    List<CartHistoryEntity> orders = List.from(state);
    orders.add(order);
    final data = cartHistoryUsecases.store(orders: orders);

    //responses
    data.fold((l) => print("error left CartHistoryCubit "), (r) {
      print("CartHistoryCubit right : ${r.length}");
      emit(r.reversed.toList());
    });
  }

    void clearCartHistory() {
    final data = cartHistoryUsecases.clear();
    data.fold((l) => print("error left clearCartItems "), (r) {
      emit([]);
    });
  }
}
