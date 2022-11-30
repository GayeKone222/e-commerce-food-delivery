import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/core/utils/regex_validator.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/presentation/bloc/Auth/auth_login_bloc/auth_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/Auth/registration_bloc/registration_bloc.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/widgets/Auth/app_text_field.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:e_commerce/features/presentation/widgets/common/custom_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController nameControler = TextEditingController();
  TextEditingController phoneControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var signUpImages = ["t.png", "f.png", "g.png"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state.status == AppStateStatus.success) {
            //go to login screen
            BlocProvider.of<NavigatorBloc>(context).add(Pop());
          }
        },
        builder: (context, state) {
          return state.status == AppStateStatus.loading
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
                        ApptextField(
                          controller: emailControler,
                          hintText: "Email",
                          icon: Icons.email,
                          validator: (val) => RegexValidators()
                              .validateEmailAdress(emailControler.text),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ApptextField(
                          isObscure: true,
                          controller: passwordControler,
                          hintText: "Password",
                          icon: Icons.password_sharp,
                          validator: (val) => RegexValidators()
                              .validatePassword(passwordControler.text),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ApptextField(
                          controller: nameControler,
                          hintText: "Name",
                          icon: Icons.person,
                          validator: (firstName) => RegexValidators()
                              .validateName(nameControler.text, "name"),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ApptextField(
                          controller: phoneControler,
                          hintText: "Phone",
                          icon: Icons.phone,
                          validator: (firstName) => RegexValidators()
                              .validatePhoneNumber(phoneControler.text),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              BlocProvider.of<RegistrationBloc>(context).add(
                                  SignUp(
                                      user: UserEntity(
                                          phone: phoneControler.text,
                                          password: passwordControler.text,
                                          email: emailControler.text,
                                          name: nameControler.text)));
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
                                text: "Sign up",
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //go to signin screen
                                    BlocProvider.of<NavigatorBloc>(context)
                                        .add(Pop());
                                  },
                                text: "Have an account already?",
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 20.sp))),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: TextSpan(
                                text:
                                    "Sign up using one of the following methods",
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 16.sp))),
                        SizedBox(
                          height: 10.h,
                        ),
                        Wrap(
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage: AssetImage(
                                          "assets/image/${signUpImages[index]}"),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
