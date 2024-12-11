import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<dynamic>> fetchProducts({int limit = 0, bool sortDesc = false}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?limit=$limit'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createProduct(dynamic newProduct) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: json.encode(newProduct),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editProduct(dynamic updatedProduct) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${updatedProduct['id']}'),
        body: json.encode(updatedProduct),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> deleteProduct(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      rethrow;
    }
  }
}

