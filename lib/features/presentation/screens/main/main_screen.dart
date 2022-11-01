import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/features/presentation/cubit/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:e_commerce/features/presentation/screens/cart_history/cart_history_screen.dart';
import 'package:e_commerce/features/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List pages = [
  const HomeScreen(),
  Container(
    child: Center(child: Text("page1")),
  ),
  const CartHistoryScreen(),
  Container(
    child: Center(child: Text("page3")),
  )
];

List pageIcons = [
  Icons.home_outlined,
  Icons.archive,
  Icons.shopping_cart,
  Icons.person
];

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppColors.mainColor,
              unselectedItemColor: Colors.amber,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: state,
              selectedFontSize: 0.0,
              unselectedFontSize: 0.0,
              onTap: (index) {
                context.read<BottomNavigationBarCubit>().changePage(index: index);
              },
              items: [
                ...pageIcons.map((e) => BottomNavigationBarItem(icon: Icon(e), label: "page${pageIcons.indexOf(e)}"))
              ]),
        );
      },
    );
  }
}
