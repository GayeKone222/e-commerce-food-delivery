import 'package:e_commerce/features/domain/entities/cart_entity.dart';
import 'package:equatable/equatable.dart';

class CartHistoryEntity extends Equatable {
  final String time;
  final List<CartEntity> cartEntities;

  const CartHistoryEntity({
    required this.cartEntities,
    required this.time,
  });

  CartHistoryEntity copyWith({String? time, List<CartEntity>? cartEntities}) {
    return CartHistoryEntity(
        time: time ?? this.time, cartEntities: cartEntities ?? this.cartEntities);
  }

  @override
  List<Object?> get props => [time, cartEntities];
}
