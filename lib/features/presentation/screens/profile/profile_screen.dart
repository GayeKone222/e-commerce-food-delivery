import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/dependency_injection.dart/injections.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/presentation/bloc/Auth/auth_login_bloc/auth_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/address_bloc/address_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/cart_history_cubit/cart_history_cubit.dart';
import 'package:e_commerce/features/presentation/widgets/common/app_icon.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/custom_loading.dart';
import 'package:e_commerce/features/presentation/widgets/profile/account_content.dart';
import 'package:e_commerce/features/presentation/widgets/profile/have_to_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AppAuthStateStatus.unAuthenticated) {
          // delete stored cart items
          context.read<AddProductToCartCubit>().clearCartItems();
          // delete stored cart history
          context.read<CartHistoryCubit>().clearCartHistory();

          BlocProvider.of<NavigatorBloc>(context)
              .add(const PushNamedAndRemoveUntil(
            route: Routes.SignInScreenRoute,
            untilRoute: Routes.SignInScreenRoute,
          ));
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<UserBloc>(),
          ),
         
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title: const Bigtext(
              text: "Profile",
              size: 24,
              color: Colors.white,
            ),
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.status == AppStateStatus.loading) {
                return const CustomLoading();
              }
              if (state.status == AppStateStatus.failure) {
                return const YouHaveToSignIn();
              }
              if (state.status == AppStateStatus.success) {
                return Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                        color: Colors.grey.withOpacity(0.2))
                  ]),
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 20.h),
                  child: Column(
                    children: [
                      const AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: 75,
                        size: 150,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AccountContent(
                                appIcon: const AppIcon(
                                  icon: Icons.person,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 50,
                                ),
                                bigtext: Bigtext(text: state.user!.name!),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              AccountContent(
                                appIcon: const AppIcon(
                                  icon: Icons.phone,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 50,
                                ),
                                bigtext: Bigtext(text: state.user!.phone!),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              AccountContent(
                                appIcon: const AppIcon(
                                  icon: Icons.email,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 50,
                                ),
                                bigtext: Bigtext(text: state.user!.email!),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    BlocProvider.of<NavigatorBloc>(context).add(
                                        PushNamed(
                                            route: Routes.AddressScreenRoute,
                                            objectParam: state.user)),
                                child: const AccountContent(
                                  appIcon: AppIcon(
                                    icon: Icons.location_on,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: 25,
                                    size: 50,
                                  ),
                                  bigtext: Bigtext(text: "Fill in your adress"),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              const AccountContent(
                                appIcon: AppIcon(
                                  icon: Icons.message_outlined,
                                  backgroundColor: Colors.redAccent,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 50,
                                ),
                                bigtext: Bigtext(text: "messages"),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(SignOut());
                                },
                                child: const AccountContent(
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: 25,
                                    size: 50,
                                  ),
                                  bigtext: Bigtext(text: "LogOut"),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
