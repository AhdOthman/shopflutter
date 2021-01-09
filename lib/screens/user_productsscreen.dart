import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/app_drawer.dart';
import '../providers/product_provider.dart';
import '../widgets/user_productitem.dart';
import './edit_productscreen.dart';
import '../providers/product.dart';

class UserProductsScreen extends StatelessWidget {
  static const routName = '/user_productsscreen';
  Future<Void> _refreshdata(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchDate();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Products',
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshdata(context),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) => UserProductItem(productData.items[i].id,
              productData.items[i].title, productData.items[i].imageUrl),
        ),
      ),
    );
  }
}
