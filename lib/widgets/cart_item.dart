
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';


class CartItem extends StatelessWidget {
  String id;
  String productId;
  String title;
  double price;
  int quantity;

  CartItem(this.id, this.productId, this.title, this.price, this.quantity);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (ctx)=> AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to remove item from cart?'),
          actions:[
            FlatButton(child: Text('No'),onPressed: (){
              Navigator.of(context).pop(false);
            },),
             FlatButton(child: Text('Yes'),onPressed: (){
              Navigator.of(context).pop(true);
            },)
          ]
        ));
      },
      
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Text('\$$price'),
              ),
            ),
            title: Text(title),
            subtitle:
                Text('\$${(price * quantity)}'.split('.')[0].substring(0, 2)),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
