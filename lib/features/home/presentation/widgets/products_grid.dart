import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.products});
  
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 238,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

