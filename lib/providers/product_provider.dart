import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopappp/models/http_exception.dart';
import 'package:shopappp/widgets/product_item.dart';
import './product.dart';
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirddddddt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get fav {
    return _items.where((proditem) => proditem.isFavorite).toList();
  }

  Future<void> fetchDate() async {
    const url =
        "https://flutter-project-9a073-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.get(url);
      final extractdata = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedprod = [];
      extractdata.forEach((prodId, prodData) {
        loadedprod.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite']));
      });

      print(json.decode(response.body));
      _items = loadedprod;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        "https://flutter-project-9a073-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          }));
      print(json.decode(response.body));
      final newproduct = Product(
          title: product.title,
          price: product.price,
          description: product.description,
          id: json.decode(response.body)['name'],
          imageUrl: product.imageUrl);

      _items.add(newproduct);
      // _items.add(value)

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Product findByid(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          "https://flutter-project-9a073-default-rtdb.firebaseio.com/products/$id.json";
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
    }
    notifyListeners();
  }

  void deleteProduct(String id) async {
    final url =
        "https://flutter-project-9a073-default-rtdb.firebaseio.com/products/$id";
    final existingprodindex = _items.indexWhere((prod) => prod.id == id);
    var existingprod = _items[existingprodindex];
    _items.removeAt(existingprodindex);
    notifyListeners();
    final response = await http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        _items.insert(existingprodindex, existingprod);
        notifyListeners();
        throw HttpException('Could not be deleted');
      }
      existingprod = null;
    });
  }
//   final url =
//       "https://flutter-project-9a073-default-rtdb.firebaseio.com/products/$id.json";
//   final existingprodindex = _items.indexWhere((prod) => prod.id == id);
//   var existingprod = _items[existingprodindex];
//   http.delete(url).then((response) {
//     existingprod = null;
//   }).catchError((_) {
//     _items.insert(existingprodindex, existingprod);
//     notifyListeners();
//   });
// _items.removeWhere((prod) => prod.id == id);
//   _items.removeAt(existingprodindex);

//   notifyListeners();
// }
}
