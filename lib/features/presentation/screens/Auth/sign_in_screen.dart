import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/presentation/bloc/Auth/auth_login_bloc/auth_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/auth_status_cubit/auth_status_cubit.dart';
import 'package:e_commerce/features/presentation/widgets/Auth/app_text_field.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/custom_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordControler = TextEditingController();

  TextEditingController phoneControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AppAuthStateStatus.authenticated) {
            //set auth status
            //
            BlocProvider.of<AuthStatusCubit>(context).isLoggedIn();
            //go to main route
            BlocProvider.of<NavigatorBloc>(context)
                .add(const PushNamed(route: Routes.MainRoute));
          }
        },
        builder: (context, state) {
          return state.status == AppAuthStateStatus.authenticating
              ? const CustomLoading()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80.r,
                              backgroundImage: const AssetImage(
                                  "assets/image/logo part 1.png"),
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 20.w),
                          child: Column(
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontSize: 70.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Sign into your account",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.grey[500],
                                ),
                              )
                            ],
                          ),
                        ),
                        ApptextField(
                          controller: phoneControler,
                          hintText: "Phone",
                          icon: Icons.phone,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ApptextField(
                          controller: passwordControler,
                          hintText: "Password",
                          icon: Icons.password_sharp,
                          isObscure: true,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                                text: TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                    text: "Sign into your account",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 20.sp))),
                            SizedBox(
                              width: 20.w,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              BlocProvider.of<AuthBloc>(context).add(SignIn(
                                  user: UserEntity(
                                      phone: phoneControler.text,
                                      password: passwordControler.text)));
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            //  height: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(30.r)),
                            child: const Center(
                              child: Bigtext(
                                text: "Sign in",
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 20.sp),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //go to signin screen
                                      BlocProvider.of<NavigatorBloc>(context)
                                          .add(const PushNamed(
                                              route: Routes.SignUpScreenRoute));
                                    },
                                  text: " Create",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainBlackColor,
                                      fontSize: 20.sp))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
