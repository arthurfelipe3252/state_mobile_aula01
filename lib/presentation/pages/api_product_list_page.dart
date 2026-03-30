import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/provider/api_product_provider.dart';
import '../widgets/product_card.dart';
import 'api_product_detail_page.dart';
import 'api_product_form_page.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ApiProductFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
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
        return ProductCard(
          product: product,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ApiProductDetailPage(product: product),
              ),
            );
          },
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ApiProductFormPage(product: product),
              ),
            );
          },
          onDelete: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Confirmar exclusao'),
                content: Text('Deseja excluir "${product.title}"?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<ApiProductProvider>()
                          .deleteProduct(product.id);
                      Navigator.pop(ctx);
                    },
                    child: const Text('Excluir',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
