import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    // ignore: sdk_version_ui_as_code
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://myshop-app-76b0a-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    // print(json.decode(response.body));
    List<OrderItem> loadedOrders = [];
    final extractedOrders = json.decode(response.body) as Map<String, dynamic>;
    if (extractedOrders == null) {
      return;
    }
    extractedOrders.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price']),
                )
                .toList()),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        'https://myshop-app-76b0a-default-rtdb.firebaseio.com/orders.json');
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
