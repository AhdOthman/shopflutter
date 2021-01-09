import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopappp/providers/cart.dart';
import '../screens/product_detail.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  //  final String imageUrl;
  //  final String title;
  //  final String id;
  //  ProductItem(this.id, this.imageUrl, this.title);
  @override
  Widget build(BuildContext context) {
    final getproduct = Provider.of<Product>(context, listen: false);
    print('product rebuild');
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailScreen.routName,
                      arguments: getproduct.id);
                },
                child: Image.network(
                  getproduct.imageUrl,
                  fit: BoxFit.cover,
                ))),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(getproduct.title, textAlign: TextAlign.center),
          leading: Consumer<Product>(
              builder: (ctx, getproduct, _) => IconButton(
                  icon: Icon(
                    getproduct.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    print("Dataaaaaaaaa" + getproduct.isFavorite.toString());
                    getproduct.presstofov();
                  })),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              cart.addItem(getproduct.id, getproduct.price, getproduct.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Item Added!!'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removesingleitem(getproduct.id);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
