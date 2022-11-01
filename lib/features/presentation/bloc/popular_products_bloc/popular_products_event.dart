part of 'popular_products_bloc.dart';

abstract class PopularProductsEvent extends Equatable {
  const PopularProductsEvent();

  @override
  List<Object> get props => [];
}

class GetPupolarProducts extends PopularProductsEvent {}
