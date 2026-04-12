import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductSizeType {
  minMedium,
  singleDouble,
  noSize,
  regularCan,
}

class ProductModel {
  final String id;
  final String name;
  final String nameAr;
  final String subtitle;
  final String subtitleAr;
  final String description;
  final String descriptionAr;
  final String imageUrl;
  final double rating;
  final ProductSizeType sizeType;
  final double priceMin;
  final double priceMedium;
  final double priceSingle;
  final double priceDouble;
  final String productPath;
  final double canPrice;

  ProductModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.subtitle,
    required this.subtitleAr,
    required this.description,
    required this.descriptionAr,
    required this.imageUrl,
    required this.rating,
    required this.sizeType,
    required this.priceMin,
    required this.priceMedium,
    required this.priceSingle,
    required this.priceDouble,
    required this.productPath,
    this.canPrice = 0.0,
  });

  factory ProductModel.fromFirestore(
    DocumentSnapshot doc, {
    required String source,
    required String categoryId,
    double canPrice = 0.0,
  }) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    final priceMin =
        double.tryParse(data['price_min']?.toString() ?? '0.0') ?? 0.0;
    final priceMedium =
        double.tryParse(data['price_medium']?.toString() ?? '0.0') ?? 0.0;
        
    final rawPriceSingle = data['price_single']?.toString() ?? data['price_min']?.toString() ?? '0.0';
    final priceSingle = double.tryParse(rawPriceSingle) ?? 0.0;

    final rawPriceDouble = data['price_double']?.toString() ?? data['price_medium']?.toString() ?? '0.0';
    final priceDouble = double.tryParse(rawPriceDouble) ?? 0.0;

    late final ProductSizeType type;
    if (source == 'products_size') {
      if (priceMin == 0 && categoryId == 'cold_beverages') {
        type = ProductSizeType.regularCan;
      } else {
        type = priceMin > 0 ? ProductSizeType.minMedium : ProductSizeType.noSize;
      }
    } else if (source == 'product_Portion') {
      type = ProductSizeType.singleDouble;
    } else {
      type = ProductSizeType.noSize;
    }

    return ProductModel(
      id: doc.id,
      name: data['name'] as String? ?? 'Unknown Product',
      nameAr: data['name_ar'] as String? ?? data['name'] as String? ?? '',
      subtitle: data['subtitle'] as String? ?? '',
      subtitleAr: data['subtitle_ar'] as String? ?? data['subtitle'] as String? ?? '',
      description: data['description'] as String? ?? '',
      descriptionAr: data['description_ar'] as String? ?? data['description'] as String? ?? '',
      imageUrl: (data['imageUrl'] ?? data['imagePath'] ?? '') as String,
      rating: double.tryParse(data['rating']?.toString() ?? '0.0') ?? 0.0,
      sizeType: type,
      priceMin: priceMin,
      priceMedium: priceMedium,
      priceSingle: priceSingle,
      priceDouble: priceDouble,
      productPath: data['productPath'] as String? ?? '',
      canPrice: canPrice,
    );
  }

  String getLocalizedName(String langCode) {
    return langCode == 'ar' ? nameAr : name;
  }

  String getLocalizedSubtitle(String langCode) {
    return langCode == 'ar' ? subtitleAr : subtitle;
  }

  String getLocalizedDescription(String langCode) {
    return langCode == 'ar' ? descriptionAr : description;
  }

  double get basePrice {
    switch (sizeType) {
      case ProductSizeType.minMedium:
        return priceMin;
      case ProductSizeType.singleDouble:
        return priceSingle;
      case ProductSizeType.regularCan:
        return priceMedium;
      case ProductSizeType.noSize:
        return priceMedium;
    }
  }

  List<String> get availableSizes {
    switch (sizeType) {
      case ProductSizeType.minMedium:
        return ['Minimum', 'Medium'];
      case ProductSizeType.singleDouble:
        return ['Single', 'Double'];
      case ProductSizeType.regularCan:
        return ['Regular', 'Can'];
      case ProductSizeType.noSize:
        return [];
    }
  }

  double priceForSize(String size) {
    switch (size) {
      case 'Minimum':
        return priceMin;
      case 'Medium':
        return priceMedium;
      case 'Single':
        return priceSingle;
      case 'Double':
        return priceDouble;
      case 'Regular':
        return priceMedium;
      case 'Can':
        return priceMedium + canPrice;
      default:
        return basePrice;
    }
  }
}

