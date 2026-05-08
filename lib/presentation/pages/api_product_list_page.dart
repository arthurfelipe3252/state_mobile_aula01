import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/viewmodels/api_product_viewmodel.dart';
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
    final vm = context.read<ApiProductViewModel>();
    if (vm.products.isEmpty && !vm.isLoading) {
      vm.loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ApiProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos - Fake API"),
      ),
      body: _buildBody(vm),
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

  Widget _buildBody(ApiProductViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                "Erro ao carregar produtos",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(vm.error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => vm.loadProducts(),
                child: const Text("Tentar novamente"),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: vm.products.length,
      itemBuilder: (context, index) {
        final product = vm.products[index];
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
                          .read<ApiProductViewModel>()
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
