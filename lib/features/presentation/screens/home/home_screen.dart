import 'package:e_commerce/features/presentation/widgets/home/food_page_body.dart';
import 'package:e_commerce/features/presentation/widgets/home/food_page_header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: const [
          MainFootPageHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      )),
    );
  }
}
