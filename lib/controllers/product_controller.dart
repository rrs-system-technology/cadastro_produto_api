import 'package:crud_flutter_api/models/product.dart';
import 'package:crud_flutter_api/services/product_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductService _service = ProductService();

  var products = <Product>[].obs;
  var categories = <String>[].obs;
  var isLoading = false.obs;

  var searchQuery = ''.obs;
  var selectedCategory = 'Todas as categorias'.obs;

  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    super.onInit();
  }

  void fetchProducts() async {
    isLoading(true);
    try {
      products.value = await _service.getAllProducts();
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar produtos');
    } finally {
      isLoading(false);
    }
  }

  void fetchCategories() async {
    try {
      final fetched = await _service.getCategories();
      categories.assignAll(fetched);
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar categorias');
    }
  }

  List<Product> get filteredProducts {
    var temp = selectedCategory.value == 'Todas as categorias'
        ? products
        : products.where((p) => p.category == selectedCategory.value).toList();

    if (searchQuery.value.isNotEmpty) {
      temp = temp
          .where((p) => p.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    return temp;
  }

  Future<void> addProduct(Product p) async {
    try {
      final product = await _service.addPrduct(p); // Chama o método salvar do sevice
      if (product.id != null) {
        products.add(product); // Atualiza a lista após gravar/criar o produto
      }
      Get.back(); // Volta para a tela anterior
    } catch (e) {
      if (kDebugMode) {
        print('Erro do cadastrar o produto: $e');
      }
    }
  }

  Future<void> updateProduct(Product p) async {
    try {
      final productAtualizado =
          await _service.updateProduct(p); // Chama o método update para atualizar

      final index = products.indexWhere((ele) => ele.id == p.id);
      if (index != -1) {
        products[index] = productAtualizado; // Atualiza a lista após alteração do produto
        products.refresh();
      }
      Get.back(); // Volta para a tela anterior
    } catch (e) {
      if (kDebugMode) {
        print('Erro do cadastrar o produto: $e');
      }
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _service.delteProduct(id);
      products.removeWhere((e) => e.id == id);
      Get.snackbar('Sucesso', 'Produto deletado');
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao deletar produto');
    }
  }
}
