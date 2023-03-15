import 'package:flutter/material.dart';
import '../Widgets/user_product_item.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';


class UserProductsPage extends StatelessWidget {
  const UserProductsPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, i) => UserProductItem(
            title: productData.items[i].title,
            imageUrl: productData.items[i].imageUrl,
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
