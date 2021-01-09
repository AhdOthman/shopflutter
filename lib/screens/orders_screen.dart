import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Order;
import '../widgets/order_item.dart';
import '../screens/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routName = '/orders_screen';
  @override
  Widget build(BuildContext context) {
    final orderdata = Provider.of<Order>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders'),),
      drawer: AppDrawer(),
      body: ListView.builder(itemCount:orderdata.orders.length, itemBuilder: (ctx, i)=> OrderItem(orderdata.orders[i]),),

    );
  }
}