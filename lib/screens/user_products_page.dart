import 'package:flutter/material.dart';
import 'package:myshop/widgets/app_drawer.dart';
import '../Widgets/user_product_item.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, i) => Column(
            children: [
              UserProductItem(
                title: productData.items[i].title,
                imageUrl: productData.items[i].imageUrl,
              ),
              const Divider(thickness: 2),
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
