import 'package:flutter/material.dart';
import 'package:shopappp/providers/product_provider.dart';
import './screens/product_overviewscreen.dart';
import './screens/product_detail.dart';
import 'package:provider/provider.dart';
import './providers/product_provider.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_productsscreen.dart';
import './screens/edit_productscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Order(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          // '/':(ctx)=> ProductOverviewScreen(),
          ProductDetailScreen.routName: (ctx) => ProductDetailScreen(),
          CartScreen.routName: (ctx) => CartScreen(),
          OrderScreen.routName: (ctx) => OrderScreen(),
          ProductOverviewScreen.routName: (ctx) => ProductOverviewScreen(),
          UserProductsScreen.routName: (ctx)=> UserProductsScreen(),
          EditProductScreen.routName: (ctx)=> EditProductScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
