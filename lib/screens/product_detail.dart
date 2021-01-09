import 'package:flutter/material.dart';
import 'package:shopappp/providers/product.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routName = '/product_detail';
  String productId;
  @override
  Widget build(BuildContext context) {
    
    final proid = ModalRoute.of(context).settings.arguments as String;
    final productsdata =
        Provider.of<ProductProvider>(context, listen: false).findByid(proid);
    String price = productsdata.price.toString() + '\$';

    return Scaffold(
        appBar: AppBar(
          title: Text(productsdata.title),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  productsdata.imageUrl,
                  fit: BoxFit.cover,
                )),
            SizedBox(height: 10),
            Text('\$${productsdata.price}'),
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  productsdata.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
                SizedBox(height: 10),
            Container(
              width: 350,
              child: FlatButton(
                child: Text(
                  'Add Item',
                  style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.title.color),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  Provider.of<Cart>(context, listen: false).addItem(productsdata.id, productsdata.price, productsdata.title);
                },
              ),
            ),SizedBox(height: 10),
  Container(
              width: 350,
              child: FlatButton(
                child: Text(
                  'remove Item',
                  style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.title.color),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: (){
            Provider.of<ProductProvider>(context, listen: false).deleteProduct(productsdata.id);
            Navigator.of(context).pop();
                },
              ),
            ),SizedBox(height: 10),
             ]),
        ));
  }
}
