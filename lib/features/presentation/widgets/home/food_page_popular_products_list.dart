import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/features/domain/entities/product_entity.dart';
import 'package:e_commerce/features/presentation/bloc/navigator_bloc/navigator_bloc.dart';
import 'package:e_commerce/features/presentation/widgets/home/food_page_popular_products_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularProductsList extends StatelessWidget {
  const PopularProductsList({Key? key, required this.popularProducts})
      : super(key: key);

  final List<ProductEntity> popularProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: popularProducts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => //navigate to PopularFoodDetails view
                BlocProvider.of<NavigatorBloc>(context).add(PushNamed(
                    route: Routes.RecommendedFoodDetails,
                    objectParam: popularProducts[index])),
            child: PopularProductsListItem(
              popularProduct: popularProducts[index],
            ),
          );
        });
  }
}
