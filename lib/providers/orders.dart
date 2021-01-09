import 'package:flutter/cupertino.dart';
import 'package:shopappp/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem with ChangeNotifier {
  String id;
  double amount;
  DateTime dateTime;
  List<CartItem> products;

  OrderItem(
      {@required this.products,
      @required this.amount,
      @required this.id,
      @required this.dateTime});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addorder(List<CartItem> cartproduct, double total) async {
    final timeStamp = DateTime.now();
    const url =
        "https://flutter-project-9a073-default-rtdb.firebaseio.com/orders.json";
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartproduct
              .map((cp) => {
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'id': cp.id,
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            products: cartproduct,
            amount: total,
            id: json.decode(response.body)['name'],
            dateTime: timeStamp));
    notifyListeners();
  }
}
