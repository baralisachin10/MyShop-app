import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../provider/order.dart';

import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemBuilder: (ctx, i) => OrderItems(
                order: orderData.orders[i],
              ),
          itemCount: orderData.orders.length),
    );
  }
}
