import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/api_product.dart';
import '../../state/provider/api_product_provider.dart';
import '../widgets/product_form_field.dart';

class ApiProductFormPage extends StatefulWidget {
  final ApiProduct? product;

  const ApiProductFormPage({super.key, this.product});

  @override
  State<ApiProductFormPage> createState() => _ApiProductFormPageState();
}

class _ApiProductFormPageState extends State<ApiProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _categoryController;
  late final TextEditingController _imageController;

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product?.title ?? '');
    _priceController = TextEditingController(
      text: widget.product != null ? widget.product!.price.toString() : '',
    );
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _categoryController =
        TextEditingController(text: widget.product?.category ?? '');
    _imageController =
        TextEditingController(text: widget.product?.image ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ApiProductProvider>();

    final product = ApiProduct(
      id: widget.product?.id ?? 0,
      title: _titleController.text,
      price: double.parse(_priceController.text),
      description: _descriptionController.text,
      category: _categoryController.text,
      image: _imageController.text.isNotEmpty
          ? _imageController.text
          : 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
      rating: widget.product?.rating ?? 0.0,
      ratingCount: widget.product?.ratingCount ?? 0,
    );

    if (isEditing) {
      await provider.updateProduct(product);
    } else {
      await provider.addProduct(product);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Produto' : 'Novo Produto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ProductFormField(
                controller: _titleController,
                label: 'Titulo',
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Informe o titulo' : null,
              ),
              ProductFormField(
                controller: _priceController,
                label: 'Preco',
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe o preco';
                  if (double.tryParse(v) == null) return 'Preco invalido';
                  return null;
                },
              ),
              ProductFormField(
                controller: _descriptionController,
                label: 'Descricao',
                maxLines: 3,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Informe a descricao' : null,
              ),
              ProductFormField(
                controller: _categoryController,
                label: 'Categoria',
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Informe a categoria' : null,
              ),
              ProductFormField(
                controller: _imageController,
                label: 'URL da Imagem',
                hint: 'Opcional - uma imagem padrao sera usada',
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEditing ? Icons.save : Icons.add),
                  label: Text(
                      isEditing ? 'Salvar Alteracoes' : 'Adicionar Produto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
