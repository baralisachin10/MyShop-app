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
    );
  }
}
