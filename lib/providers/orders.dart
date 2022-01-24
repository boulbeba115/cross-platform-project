import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'meal.dart';
import '../configs/configuration.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime orderDate;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.orderDate,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.https(API_URL, '/orders.json');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> orders = [];
      responseData.forEach((key, value) {
        var index = 0;
        var cart = (value['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: '${index++}',
            product: Meal(
                id: item['product']['id'],
                title: item['product']['title'],
                description: item['product']['description'],
                price: item['product']['price'],
                imageUrl: item['product']['imageUrl']),
            quantity: item['quantity'],
          );
        }).toList();
        orders.add(OrderItem(
            id: key,
            amount: value['amount'],
            orderDate: DateTime.parse(value['orderDate']),
            products: cart));
      });
      _orders = orders;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cardItems, double total) async {
    var url = Uri.https(API_URL, '/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'orderDate': timestamp.toIso8601String(),
        'products': cardItems
            .map((cp) => {
                  'product': {
                    'id': cp.product.id,
                    'title': cp.product.title,
                    'description': cp.product.description,
                    'price': cp.product.price,
                    'imageUrl': cp.product.imageUrl,
                    'isfavorite': cp.product.isfavorite
                  },
                  'quantity': cp.quantity,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        orderDate: timestamp,
        products: cardItems,
      ),
    );
    notifyListeners();
  }
  /*
  void addOrder(List<CartItem> cardItems, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: const Uuid().v1().toString(),
        amount: total,
        orderDate: DateTime.now(),
        products: cardItems,
      ),
    );
    notifyListeners();
  }*/
}
