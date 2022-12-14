import 'package:e_commerce/core/Routes/navigation_service.dart';
import 'package:e_commerce/core/Routes/route_generator.dart';
import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/dependency_injection.dart/injections.dart';
import 'package:e_commerce/features/presentation/bloc/Auth/auth_login_bloc/auth_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/Auth/registration_bloc/registration_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/address_bloc/address_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/popular_products_bloc/popular_products_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/address_cubit/address_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/auth_status_cubit/auth_status_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/cart_history_cubit/cart_history_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/location_type_cubit/location_type_cubit.dart';
import 'package:e_commerce/features/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
    BlocProvider<RegistrationBloc>(create: (_) => sl<RegistrationBloc>()),
    BlocProvider<BottomNavigationBarCubit>(
        create: (_) => sl<BottomNavigationBarCubit>()),
    BlocProvider<PopularProductsBloc>(create: (_) => sl<PopularProductsBloc>()),
    BlocProvider<NavigatorBloc>(create: (_) => sl<NavigatorBloc>()),
    BlocProvider<AddProductToCartCubit>(
      create: (_) => sl<AddProductToCartCubit>(),
      lazy: false,
    ),
    BlocProvider<CartHistoryCubit>(
      create: (_) => sl<CartHistoryCubit>(),
      lazy: false,
    ),
    BlocProvider<AuthStatusCubit>(create: (_) => sl<AuthStatusCubit>()),
    BlocProvider<AddressCubit>(create: (_) => sl<AddressCubit>()),
     //BlocProvider(create: (_) => sl<AddressBloc>()..add(GetUserAddress()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food delivery',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: child,
          navigatorKey: sl<NavigationService>().navigatorKey,
          initialRoute: Routes.SplashRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
      child: const SplashScreen(),
    );
  }
}
