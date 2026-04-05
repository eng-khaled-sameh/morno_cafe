import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/features/product_detail/presentation/widgets/add_to_cart_bar.dart';
import 'package:caffe_app/features/product_detail/presentation/widgets/product_detail_image.dart';
import 'package:caffe_app/features/product_detail/presentation/widgets/product_detail_info.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String _selectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.product.sizeType == ProductSizeType.noSize) {
      _selectedSize = '';
    } else if (widget.product.sizeType == ProductSizeType.minMedium) {
      _selectedSize = 'Minimum';
    } else {
      _selectedSize = 'Single';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ProductDetailImage(product: widget.product),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductDetailInfo(
                      product: widget.product,
                      selectedSize: _selectedSize,
                      onSizeChanged: (size) => setState(() => _selectedSize = size),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddToCartBar(
        product: widget.product,
        selectedSize: _selectedSize,
      ),
    );
  }
}

