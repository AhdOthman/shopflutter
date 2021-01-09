import 'package:flutter/material.dart';
import 'package:shopappp/providers/cart.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import './cart_screen.dart';
import '../screens/app_drawer.dart';
import '../providers/product_provider.dart';
import '../widgets/user_productitem.dart';

enum filter { Fav, All }

class ProductOverviewScreen extends StatefulWidget {
  static const routName = '/product_overviewscreen';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showfav = false;
  var _isinit = true;
  var _isload = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isload = true;
      });
      Provider.of<ProductProvider>(context).fetchDate().then((_) {
        setState(() {
          _isload = false;
        });
      });
    }
    _isinit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Shop App'),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (filter selectedvalue) {
                setState(() {
                  if (selectedvalue == filter.Fav) {
                    _showfav = true;
                  } else
                    _showfav = false;
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('only fav'),
                  value: filter.Fav,
                ),
                PopupMenuItem(
                  child: Text('show all'),
                  value: filter.All,
                )
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemcount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routName);
                },
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: _isload
            ? Center(child: CircularProgressIndicator())
            : ProductsGrid(_showfav));
  }
}
