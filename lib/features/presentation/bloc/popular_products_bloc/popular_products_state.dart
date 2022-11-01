part of 'popular_products_bloc.dart';



class PopularProductsState extends Equatable {
  final AppStateStatus status;
  final List<ProductEntity>? products;

  const PopularProductsState(
      {this.status = AppStateStatus.initial, this.products});

  PopularProductsState copyWith(
      {AppStateStatus? status, List<ProductEntity>? products}) {
    return PopularProductsState(
        status: status ?? this.status, products: products ?? this.products);
  }

  @override
  List<Object?> get props => [status, products];
}
