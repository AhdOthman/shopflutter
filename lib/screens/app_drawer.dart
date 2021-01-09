import 'package:flutter/material.dart';
import 'orders_screen.dart';
import 'cart_screen.dart';
import 'product_overviewscreen.dart';
import '../screens/user_productsscreen.dart';

class AppDrawer extends StatelessWidget {
  Widget buildlisttile(IconData icon, String title, Function onhand) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
      ),
      onTap: onhand,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          height: 100,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text('Shop App',
                style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryTextTheme.title.color)),
          ),
        ),
      
        buildlisttile(Icons.home, 'Home', () {
          Navigator.of(context)
              .pushReplacementNamed(ProductOverviewScreen.routName);
        }),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      
        buildlisttile(Icons.payment, 'Show Orders', () {
          Navigator.of(context).pushReplacementNamed(OrderScreen.routName);
        }),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        
        buildlisttile(Icons.shopping_cart, 'Cart', () {
          Navigator.of(context).pushReplacementNamed(CartScreen.routName);
        }),
            Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        
        buildlisttile(Icons.edit, 'Manage Products', () {
          Navigator.of(context).pushReplacementNamed(UserProductsScreen.routName);
        })
      ]),
    );
  }
}
