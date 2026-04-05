import 'package:caffe_app/features/home/data/models/product_model.dart';

class CartItemModel {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final int quantity;
  final String size;
  final ProductSizeType sizeType;
  final double priceMin;
  final double priceMedium;
  final double priceSingle;
  final double priceDouble;

  CartItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.size,
    required this.sizeType,
    required this.priceMin,
    required this.priceMedium,
    required this.priceSingle,
    required this.priceDouble,
    this.quantity = 1,
  });

  double priceForSize(String newSize) {
    if (sizeType == ProductSizeType.noSize) {
      return price;
    }
    switch (newSize) {
      case 'Minimum':
        return priceMin;
      case 'Medium':
        return priceMedium;
      case 'Single':
        return priceSingle;
      case 'Double':
        return priceDouble;
      default:
        return price;
    }
  }

  CartItemModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    double? price,
    String? imageUrl,
    int? quantity,
    String? size,
    ProductSizeType? sizeType,
    double? priceMin,
    double? priceMedium,
    double? priceSingle,
    double? priceDouble,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      sizeType: sizeType ?? this.sizeType,
      priceMin: priceMin ?? this.priceMin,
      priceMedium: priceMedium ?? this.priceMedium,
      priceSingle: priceSingle ?? this.priceSingle,
      priceDouble: priceDouble ?? this.priceDouble,
    );
  }
}

