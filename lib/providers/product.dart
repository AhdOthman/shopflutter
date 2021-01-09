import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.description,
    this.id,
    this.imageUrl,
    this.isFavorite = false,
    this.price,
    this.title,
  });
  void _setval(bool newval) {
    isFavorite = newval;
    notifyListeners();
  }

  Future<void> presstofov() async {
    final oldstatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        "https://flutter-project-9a073-default-rtdb.firebaseio.com/products/$id.json";
    try {
      final response =
          await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setval(oldstatus);
      }
    } catch (error) {
      _setval(oldstatus);
    }
  }
}
