import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YouHaveToSignIn extends StatelessWidget {
  const YouHaveToSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.maxFinite,
          height: 160.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/signintocontinue.png"))),
        ),
        TextButton(
            style: TextButton.styleFrom(backgroundColor: AppColors.mainColor),
            onPressed: () {
              BlocProvider.of<NavigatorBloc>(context).add(const PushNamed(
                route: Routes.SignInScreenRoute,
              ));
            },
            child: const Bigtext(
              text: "Sign in",
              color: Colors.white,
            ))
      ],
    );
  }
}
