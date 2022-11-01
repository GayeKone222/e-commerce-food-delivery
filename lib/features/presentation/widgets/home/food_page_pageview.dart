import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/utils/dimensions.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/widgets/home/main_pageview_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodPagePageView extends StatelessWidget {
  const FoodPagePageView(
      {Key? key,
      required this.pageController,
      required this.currentPageValue,
      required this.popularProducts})
      : super(key: key);

  final PageController pageController;
  final double currentPageValue;
  final List<ProductEntity> popularProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.pageView,
      child: PageView.builder(
          controller: pageController,
          itemCount: popularProducts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => //navigate to PopularFoodDetails view
                  BlocProvider.of<NavigatorBloc>(context).add(PushNamed(
                      route: Routes.PopularFoodDetails,
                      objectParam: popularProducts[index])),
              child: MainPageViewItem(
                currentPageValue: currentPageValue,
                index: index,
                height: Dimensions.pageViewContainer,
                popularProduct: popularProducts[index],
              ),
            );
          }),
    );
  }
}
