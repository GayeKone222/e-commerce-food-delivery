import 'package:e_commerce/core/Routes/navigation_service.dart';
import 'package:e_commerce/features/data/datasources/local/User_Address/user_address_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/local/api_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/local/auth/auth_api_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/local/cart_history_local_data_source_references.dart';
import 'package:e_commerce/features/data/datasources/local/cart_local_data_source_references.dart';
import 'package:e_commerce/features/data/datasources/remote/address/address_api_remote_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/auth/auth_api_remote_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/products/api_remote_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/user/user_api_remote_data_source.dart';
import 'package:e_commerce/features/data/repositories/address_repository.dart';
import 'package:e_commerce/features/data/repositories/auth_repository.dart';
import 'package:e_commerce/features/data/repositories/cart_hsitory_repository.dart';
import 'package:e_commerce/features/data/repositories/cart_repository.dart';
import 'package:e_commerce/features/data/repositories/popular_product_repository.dart';
import 'package:e_commerce/features/data/repositories/user_repository.dart';
import 'package:e_commerce/features/domain/repositories/address_repository.dart';
import 'package:e_commerce/features/domain/repositories/auth_repository.dart';
import 'package:e_commerce/features/domain/repositories/cart_history_repository.dart';
import 'package:e_commerce/features/domain/repositories/cart_repository.dart';
import 'package:e_commerce/features/domain/repositories/popular_product_repository.dart';
import 'package:e_commerce/features/domain/repositories/user_repository.dart';
import 'package:e_commerce/features/domain/usecases/address_usecases/address_usecases.dart';
import 'package:e_commerce/features/domain/usecases/auth_usecases/auth_usecases.dart';
import 'package:e_commerce/features/domain/usecases/cart_history_usecases/cart_history.dart';
import 'package:e_commerce/features/domain/usecases/popular_product_usecases/get_popular_product.dart';
import 'package:e_commerce/features/domain/usecases/stored_cart_items_usecases/stored_cart_items.dart';
import 'package:e_commerce/features/domain/usecases/user_usecases/user_useecases.dart';
import 'package:e_commerce/features/presentation/bloc/Auth/auth_login_bloc/auth_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/Auth/registration_bloc/registration_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/address_bloc/address_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/popular_products_bloc/popular_products_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/address_cubit/address_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/auth_status_cubit/auth_status_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/cart_history_cubit/cart_history_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/location_type_cubit/location_type_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/popular_food_update_quantity_cubit/popular_food_update_quantity_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/position_cubit/position_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //navigator
  sl.registerLazySingleton(() => NavigationService());
//blocs

  sl.registerFactory(
      () => AuthBloc(authUsecases: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => RegistrationBloc(authUsecases: sl(), sharedPreferences: sl()));

  sl.registerFactory(() => NavigatorBloc(
        navigationService: sl(),
      ));
  sl.registerFactory(() => PopularProductsBloc(
        pupolarProductsUsecases: sl(),
      )..add(GetPupolarProducts()));

  sl.registerFactory(() => AddressBloc(addressUsecases: sl()));

  //UserBloc

  sl.registerFactory(() => UserBloc(
        userUsecases: sl(),
      )..add(GetUserInfo()));

//Cubits

  sl.registerLazySingleton(() => BottomNavigationBarCubit());
  sl.registerFactory(
      () => PopularFoodUpdateQuantityCubit(addProductToCartCubit: sl()));
  sl.registerLazySingleton(
      () => AddProductToCartCubit(cartUsecases: sl())..init());
  sl.registerLazySingleton(
      () => CartHistoryCubit(cartHistoryUsecases: sl())..init());

  sl.registerLazySingleton(() => AuthStatusCubit(sharedPreferences: sl()));

  sl.registerLazySingleton(() => AddressCubit(addressUsecases: sl()));

  sl.registerLazySingleton(() => PositionCubit());
  
  sl.registerLazySingleton(() => LocationTypeCubit());

//usecases
  sl.registerLazySingleton<PupolarProductsUsecases>(
      () => PupolarProductsUsecases(popularProductRepository: sl()));

  sl.registerLazySingleton<CartUsecases>(
      () => CartUsecases(cartRepository: sl()));

  sl.registerLazySingleton<CartHistoryUsecases>(
      () => CartHistoryUsecases(cartHistoryRepository: sl()));

  sl.registerLazySingleton<AuthUsecases>(
      () => AuthUsecases(authRepository: sl()));

  sl.registerLazySingleton<UserUsecases>(
      () => UserUsecases(userRepository: sl()));

  sl.registerLazySingleton<AddressUsecases>(
      () => AddressUsecases(addressRepository: sl()));

//repositories
  sl.registerLazySingleton<PopularProductRepository>(() =>
      PopularProductRepositoryImpl(
          apiRemoteDataSource: sl(), apiLocalDataDataSource: sl()));

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(
        cartLocalDataSource: sl(),
      ));

  sl.registerLazySingleton<CartHistoryRepository>(
      () => CartHistoryRepositoryImpl(
            cartHistoryLocalDataSource: sl(),
          ));
  //authRepository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      apiAuthRemoteDataSource: sl(), authLocalDataSource: sl()));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      apiUserRemoteDataSource: sl(), authLocalDataSource: sl()));

  sl.registerLazySingleton<AddressRepository>(() => AddressRepositoryImpl(
      addressRemoteDataSource: sl(),
      authLocalDataSource: sl(),
      addressLocalDataSource: sl()));

//data sources
//remote

  sl.registerLazySingleton<ApiAuthRemoteDataSource>(
      () => ApiAuthRemoteDataSourceImpl(
            httpClient: sl(),
          ));

  sl.registerLazySingleton<ApiUserRemoteDataSource>(
      () => ApiUserRemoteDataSourceImpl(
            httpClient: sl(),
          ));

  sl.registerLazySingleton<ApiRemoteDataSource>(() => ApiRemoteDataSourceImpl(
        httpClient: sl(),
      ));

  sl.registerLazySingleton<ApiAddressRemoteDataSource>(
      () => ApiAddressRemoteDataSourceImpl(
            httpClient: sl(),
          ));

  //local

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ApiLocalDataSource>(() => ApiLocalDataSourceImpl());

  sl.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<CartHistoryLocalDataSource>(
      () => CartHistoryLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<UserAddressLocalDataSource>(
      () => UserAddressLocalDataSourceImpl(sharedPreferences: sl()));

//externals
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Client>(() => Client());
}
