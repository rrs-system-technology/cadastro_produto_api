import 'package:crud_flutter_api/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/theme_controller.dart';
import 'product_form_page.dart';
import 'widgets/custom_dropdown.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final controller = Get.find<ProductController>();
  final _searchController = TextEditingController();
  final themeMode = Get.find<ThemeController>().themeMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          'Produtos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GetX<ThemeController>(
              builder: (themeController) {
                final isDark = themeController.themeMode.value == ThemeMode.dark;
                return Tooltip(
                  message: isDark ? 'Modo Claro' : 'Modo Escuro',
                  child: IconButton(
                    icon: Icon(
                      isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      color: Colors.white,
                    ),
                    onPressed: themeController.toggleTheme,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final allCategories = ['Todas as categorias', ...controller.categories];

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // 🔍 Filtro e busca (Fixo)
              CustomDropdown(
                label: 'Pesquisa por categoria',
                value: controller.selectedCategory.value,
                items: allCategories,
                hint: 'Selecione uma categoria',
                onChanged: (value) {
                  controller.selectedCategory.value = value!;
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Obx(() {
                    return controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              controller.searchQuery.value = '';
                            },
                          )
                        : const SizedBox.shrink();
                  }),
                  hintText: 'Buscar por nome...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  controller.searchQuery.value = value;
                },
              ),
              const SizedBox(height: 16),

              // 🛍️ Lista de produtos (Rolável)
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 8, // largura da barra
                  radius: const Radius.circular(12), // cantos arredondados
                  trackVisibility: true, // exibe o trilho de fundo
                  scrollbarOrientation: ScrollbarOrientation.right, // posição direita
                  interactive: true, // permite clicar e arrastar
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 54),
                    child: ListView.builder(
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = controller.filteredProducts[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.image, size: 60),
                                  ),
                                ),
                                title: Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      'R\$ ${product.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      product.category,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      tooltip: 'Editar',
                                      onPressed: () {
                                        Get.to(() => ProductFormPage(product: product));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      tooltip: 'Excluir',
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: 'Confirmar',
                                          middleText: 'Deseja excluir este produto?',
                                          textCancel: 'Cancelar',
                                          textConfirm: 'Excluir',
                                          confirmTextColor: Colors.white,
                                          buttonColor: Colors.red,
                                          onConfirm: () {
                                            controller.deleteProduct(product.id!);
                                            Get.back();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeMode.value == ThemeMode.dark ? Colors.white : const Color(0xFF512DA8),
        onPressed: () {
          Get.to(() => ProductFormPage());
        },
        child: Icon(
          Icons.add,
          color: themeMode.value == ThemeMode.dark ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
