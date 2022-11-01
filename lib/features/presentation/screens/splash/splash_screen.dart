import 'dart:async';

import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 3), () {
      BlocProvider.of<NavigatorBloc>(context)
                            .add(const PushReplacementNamed(route: Routes.MainRoute));
                       
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: animation,
                child: Image.asset(
                  "assets/image/logo part 1.png",
                  width: 250.w,
                ),
              ),
              Image.asset(
                "assets/image/logo part 2.png",
                width: 250.w,
              ),
            ],
          ),
        ));
  }
}
