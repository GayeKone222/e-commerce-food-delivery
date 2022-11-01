import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/domain/usecases/popular_product_usecases/get_popular_product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_products_event.dart';
part 'popular_products_state.dart';

class PopularProductsBloc
    extends Bloc<PopularProductsEvent, PopularProductsState> {
  final PupolarProductsUsecases pupolarProductsUsecases;
  PopularProductsBloc({required this.pupolarProductsUsecases})
      : super(const PopularProductsState()) {
    on<GetPupolarProducts>(_onGetPupolarProducts);
  }

  void _onGetPupolarProducts(
      GetPupolarProducts event, Emitter<PopularProductsState> emit) async {
    emit(state.copyWith(status: AppStateStatus.loading));

    final result = await pupolarProductsUsecases.get();

    result.fold(
        (l) => emit(state.copyWith(status: AppStateStatus.failure)),
        (r) => emit(state.copyWith(
            status: AppStateStatus.success, products: r)));
  }
}
