import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';


class ProductsGrid extends StatelessWidget {
  final bool myfav;
  ProductsGrid(this.myfav);


  @override
  Widget build(BuildContext context) {
    final productdata = Provider.of<ProductProvider>(context);
    final products = myfav? productdata.fav : productdata.items;
    return  GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          itemBuilder: (ctx, i) =>  ChangeNotifierProvider.value(
            value: products[i],
           // create: (c)=> products[i],
                      child: ProductItem(
              // products[i].id,
              // products[i].imageUrl,
              // products[i].title
            ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10));
  }
}