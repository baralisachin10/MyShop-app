import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FilterOption {
  favorites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var isFavs = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.favorites) {
                  isFavs = true;
                } else {
                  isFavs = false;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: FilterOption.favorites, child: Text('Only Favorites')),
              const PopupMenuItem(
                  value: FilterOption.all, child: Text('Show All')),
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductsGrid(isFavs),
    );
  }
}
