import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  static const routeName = '/productDetails';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments; //we got an product id
    return Scaffold(
      appBar: AppBar(
        title: const Text("title"),
      ),
    );
  }
}
