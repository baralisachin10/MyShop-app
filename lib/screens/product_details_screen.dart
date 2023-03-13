import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  static const routeName = '/productDetails';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)!.settings.arguments; //we got an product id
    final loadedProduct = Provider.of<Products>(
      context,
      // listen: false, if we don't want to update the data
    ).findById(productId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                loadedProduct.description,
                softWrap: true,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
