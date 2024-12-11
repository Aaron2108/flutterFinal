import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:labfinalapi/services/api_service.dart'; // Import ApiService
import 'package:labfinalapi/widgets/card.dart';
import 'package:labfinalapi/widgets/editProduct.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<dynamic> products = [];
  bool isDescending = false;
  final ApiService _apiService = ApiService(); // Create an instance of ApiService

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts({int limit = 0, bool sortDesc = false}) async {
    try {
      final fetchedProducts = await _apiService.fetchProducts(limit: limit, sortDesc: sortDesc);
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void toggleSortOrder() {
    setState(() {
      isDescending = !isDescending;
    });
    fetchProducts(sortDesc: isDescending);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: Icon(isDescending ? Icons.sort_by_alpha : Icons.sort),
            onPressed: toggleSortOrder,
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onDelete: () => deleteProduct(product['id']),
                  onEdit: () => editProduct(product),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: createProduct,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _apiService.deleteProduct(id);
      setState(() {
        products.removeWhere((product) => product['id'] == id);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

Future<void> createProduct() async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Create New Product'),
        content: EditProductModal(
          product: null, // Passing null for creating a new product
          onSave: (newProduct) async {
            try {
              // Crear el producto a través de la API
              await _apiService.createProduct(newProduct);
              // Refrescar la lista después de crear el producto
              fetchProducts();
              Navigator.pop(context); // Close the modal
            } catch (e) {
              print('Error: $e');
            }
          },
        ),
      );
    },
  );
}

Future<void> editProduct(dynamic product) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Product'),
        content: EditProductModal(
          product: product,
          onSave: (updatedProduct) async {
            try {
              // Editar el producto a través de la API
              await _apiService.editProduct(updatedProduct);
              // Refrescar la lista después de editar el producto
              fetchProducts();
              Navigator.pop(context); // Close the modal
            } catch (e) {
              print('Error: $e');
            }
          },
        ),
      );
    },
  );
}

}
