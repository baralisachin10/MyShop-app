import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../widgets/products_grid.dart';
import '../widgets/cart_badge.dart';
import 'cart_screen.dart';

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
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => CartBadge(
              value: cart.cartItemCount.toString(),
              color: null,
              child: child!,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart)),
          )
        ],
      ),
      body: ProductsGrid(isFavs),
    );
  }
}
