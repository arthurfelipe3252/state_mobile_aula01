
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/product_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ProductProvider>();
    final lista = prov.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        actions: [
          TextButton.icon(
            onPressed: prov.toggleFilter,
            icon: Icon(prov.showOnlyFavorites ? Icons.star : Icons.star_border),
            label: Text("${prov.favoriteCount}"),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(prod.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            Text("R\$ ${prod.price.toStringAsFixed(2)}"),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => prov.toggleFavorite(prod),
                        icon: Icon(
                          prod.favorite ? Icons.favorite : Icons.favorite_border,
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
