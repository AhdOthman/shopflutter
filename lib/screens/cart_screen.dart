import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import '../screens/app_drawer.dart';

class CartScreen extends StatelessWidget {
  static const routName = '/cart_screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      drawer: AppDrawer(),
      body: Column(children: <Widget>[
        Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total Amount'),
                    Chip(
                      label: Text(
                        '\$${cart.totalamount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Ordernow(cart: cart)
                  ]),
            )),
        SizedBox(height: 10),
        Expanded(
            child: ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (ctx, i) => CartItem(
            cart.items.values.toList()[i].id,
            cart.items.keys.toList()[i],
            cart.items.values.toList()[i].title,
            cart.items.values.toList()[i].price,
            cart.items.values.toList()[i].quantity,
          ),
        ))
      ]),
    );
  }
}

class Ordernow extends StatefulWidget {
  const Ordernow({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrdernowState createState() => _OrdernowState();
}

class _OrdernowState extends State<Ordernow> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Theme.of(context).primaryColor,
        onPressed: (widget.cart.totalamount <= 0 || _isLoading)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Order>(context, listen: false).addorder(
                    widget.cart.items.values.toList(), widget.cart.totalamount);
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clearcart();
              },
        child: _isLoading
            ? CircularProgressIndicator()
            : Text(
                'PLACE ORDER',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.title.color,
                ),
              ));
  }
}
