import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final dynamic product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductCard({
    required this.product,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product['image'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Text(
              product['title'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Price: \$${product['price']}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
