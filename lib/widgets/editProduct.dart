import 'dart:convert';
import 'package:flutter/material.dart';

class EditProductModal extends StatefulWidget {
  final dynamic product;
  final Function(dynamic) onSave;

  const EditProductModal({super.key, required this.product, required this.onSave});

  @override
  _EditProductModalState createState() => _EditProductModalState();
}

class _EditProductModalState extends State<EditProductModal> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product?['title'] ?? '');
    _priceController = TextEditingController(text: widget.product?['price']?.toString() ?? '0.0');
    _descriptionController = TextEditingController(text: widget.product?['description'] ?? '');
    _imageController = TextEditingController(text: widget.product?['image'] ?? '');
    _categoryController = TextEditingController(text: widget.product?['category'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        TextField(
          controller: _priceController,
          decoration: const InputDecoration(labelText: 'Price'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        TextField(
          controller: _imageController,
          decoration: const InputDecoration(labelText: 'Image URL'),
        ),
        TextField(
          controller: _categoryController,
          decoration: const InputDecoration(labelText: 'Category'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final updatedProduct = {
              'id': widget.product?['id'], // If it's a new product, this will be null
              'title': _titleController.text,
              'price': double.tryParse(_priceController.text) ?? 0.0,
              'description': _descriptionController.text,
              'category': _categoryController.text,
              'image': _imageController.text,
            };
            widget.onSave(updatedProduct); // Save the updated or new product
          },
          child: Text(widget.product == null ? 'Create Product' : 'Save Changes'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}
