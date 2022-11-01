import 'package:e_commerce/core/Routes/navigation_service.dart';
import 'package:e_commerce/features/data/datasources/local/api_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/local/cart_history_local_data_source_references.dart';
import 'package:e_commerce/features/data/datasources/local/cart_local_data_source_references.dart';
import 'package:e_commerce/features/data/datasources/remote/api_remote_data_source.dart';
import 'package:e_commerce/features/data/repositories/cart_hsitory_repository.dart';
import 'package:e_commerce/features/data/repositories/cart_repository.dart';
import 'package:e_commerce/features/data/repositories/popular_product_repository.dart';
import 'package:e_commerce/features/domain/repositories/cart_history_repository.dart';
import 'package:e_commerce/features/domain/repositories/cart_repository.dart';
import 'package:e_commerce/features/domain/repositories/popular_product_repository.dart';
import 'package:e_commerce/features/domain/usecases/cart_history_usecases/cart_history.dart';
import 'package:e_commerce/features/domain/usecases/popular_product_usecases/get_popular_product.dart';
import 'package:e_commerce/features/domain/usecases/stored_cart_items_usecases/stored_cart_items.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/popular_products_bloc/popular_products_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/cart_history_cubit/cart_history_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/popular_food_update_quantity_cubit/popular_food_update_quantity_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //navigator
  sl.registerLazySingleton(() => NavigationService());
//blocs

  sl.registerFactory(() => NavigatorBloc(
        navigationService: sl(),
      ));
  sl.registerFactory(() => PopularProductsBloc(
        pupolarProductsUsecases: sl(),
      )..add(GetPupolarProducts()));

//Cubits

  sl.registerLazySingleton(() => BottomNavigationBarCubit());
  sl.registerFactory(
      () => PopularFoodUpdateQuantityCubit(addProductToCartCubit: sl()));
  sl.registerLazySingleton(
      () => AddProductToCartCubit(cartUsecases: sl())..init());
  sl.registerLazySingleton(
      () => CartHistoryCubit(cartHistoryUsecases: sl())..init());

//usecases
  sl.registerLazySingleton<PupolarProductsUsecases>(
      () => PupolarProductsUsecases(popularProductRepository: sl()));

  sl.registerLazySingleton<CartUsecases>(
      () => CartUsecases(cartRepository: sl()));

  sl.registerLazySingleton<CartHistoryUsecases>(
      () => CartHistoryUsecases(cartHistoryRepository: sl()));

//repositories
  sl.registerLazySingleton<PopularProductRepository>(() =>
      PopularProductRepositoryImpl(
          apiRemoteDataSource: sl(), apiDataDataSource: sl()));

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(
        cartLocalDataSource: sl(),
      ));

  sl.registerLazySingleton<CartHistoryRepository>(
      () => CartHistoryRepositoryImpl(
            cartHistoryLocalDataSource: sl(),
          ));

//data sources
//remote
  sl.registerLazySingleton<ApiRemoteDataSource>(() => ApiRemoteDataSourceImpl(
        httpClient: sl(),
      ));
  //local
  sl.registerLazySingleton<ApiLocalDataSource>(() => ApiLocalDataSourceImpl());

  sl.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<CartHistoryLocalDataSource>(
      () => CartHistoryLocalDataSourceImpl(sharedPreferences: sl()));

//externals
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Client>(() => Client());
}
