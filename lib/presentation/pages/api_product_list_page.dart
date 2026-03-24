import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/api_product_provider.dart';
import 'api_product_detail_page.dart';

class ApiProductListPage extends StatefulWidget {
  const ApiProductListPage({super.key});

  @override
  State<ApiProductListPage> createState() => _ApiProductListPageState();
}

class _ApiProductListPageState extends State<ApiProductListPage> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<ApiProductProvider>();
    if (provider.products.isEmpty && !provider.isLoading) {
      provider.loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ApiProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos - Fake API"),
      ),
      body: _buildBody(prov),
    );
  }

  Widget _buildBody(ApiProductProvider prov) {
    if (prov.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (prov.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                "Erro ao carregar produtos",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(prov.error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => prov.loadProducts(),
                child: const Text("Tentar novamente"),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: prov.products.length,
      itemBuilder: (context, index) {
        final product = prov.products[index];
        return Card(
          child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),
            title: Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "R\$ ${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ApiProductDetailPage(product: product),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
