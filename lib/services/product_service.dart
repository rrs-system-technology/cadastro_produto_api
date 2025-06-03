import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((j) => Product.fromJson(j)).toList();
    } else {
      throw Exception('Erro ao buscar os produtos.');
    }
  }

  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.cast<String>();
    } else {
      throw Exception('Erro ao buscar categorias');
    }
  }

  Future<Product> addPrduct(Product product) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao criar o produto.');
    }
  }

  Future<Product> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao criar o produto.');
    }
  }

  Future<void> delteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao excluir o produto.');
    }
  }
}

void main() async {
  ProductService service = ProductService();
  final listProducts = await service.getAllProducts();
  for (var prod in listProducts) {
    if (kDebugMode) {
      print('Titulo: ${prod.title} - Price: ${prod.price}');
    }
  }
}
