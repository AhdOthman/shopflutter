import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopappp/providers/product_provider.dart';
import '../providers/cart.dart';
import '../screens/edit_productscreen.dart';

class UserProductItem extends StatelessWidget {
  String imageUrl;
  String title;
  String id;
  UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routName, arguments: id);
            },
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              try {
                await Provider.of<ProductProvider>(context, listen: false)
                    .deleteProduct(id);
              } catch (error) {
                scaffold
                    .showSnackBar(SnackBar(content: Text('Delete Failed!')));
              }
              ;
            },
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
