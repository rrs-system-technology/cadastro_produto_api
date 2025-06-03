import 'package:crud_flutter_api/controllers/product_controller.dart';
import 'package:crud_flutter_api/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFormPage extends StatelessWidget {
  final Product? product;
  ProductFormPage({super.key, this.product});

  final _formKey = GlobalKey<FormState>();
  final ProductController controller = Get.find();

  final RxString title = ''.obs;
  final RxString price = ''.obs;
  final RxString description = ''.obs;
  final RxString imageUrl = ''.obs;
  final RxnString selectedCategory = RxnString();

  final List<String> defaultCategories = ['Eletrônicos', 'Roupas', 'Livros', 'Alimentos', 'Outros'];

  bool _isValidUrl(String url) => Uri.tryParse(url)?.hasAbsolutePath ?? false;

  void _save() {
    if (_formKey.currentState!.validate()) {
      final productModel = Product(
        id: product?.id,
        title: title.value,
        price: double.tryParse(price.value) ?? 0,
        description: description.value,
        category: selectedCategory.value ?? '',
        image: imageUrl.value,
      );

      if (product == null) {
        controller.addProduct(productModel);
      } else {
        controller.updateProduct(productModel);
      }
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Preencher se for edição
    if (product != null) {
      title.value = product!.title;
      price.value = product!.price.toString();
      description.value = product!.description;
      selectedCategory.value = product!.category;
      imageUrl.value = product!.image;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(6),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          product == null ? 'Cadastrando Produto' : 'Atualizando Produto',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Título
                        TextFormField(
                          initialValue: title.value,
                          onChanged: (value) => title.value = value,
                          decoration: const InputDecoration(
                            labelText: 'Título',
                            prefixIcon: Icon(Icons.title),
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) => v!.trim().isEmpty ? 'Informe o título' : null,
                        ),
                        const SizedBox(height: 16),

                        // Preço
                        TextFormField(
                          initialValue: price.value,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => price.value = value,
                          decoration: const InputDecoration(
                            labelText: 'Preço',
                            prefixIcon: Icon(Icons.attach_money),
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) => v!.trim().isEmpty ? 'Informe o preço' : null,
                        ),
                        const SizedBox(height: 16),

                        // Descrição
                        TextFormField(
                          initialValue: description.value,
                          onChanged: (value) => description.value = value,
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            prefixIcon: Icon(Icons.description),
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) => v!.trim().isEmpty ? 'Informe a descrição' : null,
                        ),
                        const SizedBox(height: 16),

                        // Categoria
                        DropdownButtonFormField<String>(
                          value: selectedCategory.value,
                          items: controller.categories.isNotEmpty
                              ? controller.categories
                                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                                  .toList()
                              : defaultCategories
                                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                                  .toList(),
                          onChanged: (value) => selectedCategory.value = value,
                          decoration: const InputDecoration(
                            labelText: 'Categoria',
                            prefixIcon: Icon(Icons.category),
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) => v == null ? 'Selecione a categoria' : null,
                        ),
                        const SizedBox(height: 16),

                        // Imagem
                        TextFormField(
                          initialValue: imageUrl.value,
                          onChanged: (value) => imageUrl.value = value,
                          decoration: const InputDecoration(
                            labelText: 'URL da Imagem',
                            prefixIcon: Icon(Icons.image),
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) => v!.trim().isEmpty ? 'Informe a URL da imagem' : null,
                        ),
                        const SizedBox(height: 16),

                        // Preview
                        if (imageUrl.value.isNotEmpty && _isValidUrl(imageUrl.value))
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imageUrl.value,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Text('Imagem inválida ou não carregada'),
                                ),
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.close),
                                label: const Text('Remover imagem'),
                                onPressed: () => imageUrl.value = '',
                              ),
                            ],
                          ),

                        const SizedBox(height: 24),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton.icon(
                            icon: Icon(product == null ? Icons.save : Icons.save_as),
                            label: Text(product == null ? 'Salvar Produto' : 'Atualizar Produto'),
                            onPressed: _save,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
