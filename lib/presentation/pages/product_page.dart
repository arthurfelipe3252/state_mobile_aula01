import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();
    final lista = vm.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        actions: [
          TextButton.icon(
            onPressed: vm.toggleFilter,
            icon: Icon(vm.showOnlyFavorites ? Icons.star : Icons.star_border),
            label: Text("${vm.favoriteCount}"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            for (var prod in lista)
              Card(
                color: prod.favorite ? Colors.yellow[50] : null,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(prod.name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            Text("R\$ ${prod.price.toStringAsFixed(2)}"),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => vm.toggleFavorite(prod),
                        icon: Icon(
                          prod.favorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: prod.favorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
