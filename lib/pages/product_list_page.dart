import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import 'package:flutter/services.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products = [];

  Future<void> loadProducts() async {
    final data = await rootBundle.loadString('assets/products.json');
    final List jsonResult = json.decode(data);
    setState(() {
      products = jsonResult.map((e) => Product.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 3 / 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (_, index) => ProductItem(product: products[index]),
      ),
    );
  }
}
