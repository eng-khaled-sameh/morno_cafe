import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final String nameAr;
  final List<ProductModel> products;

  CategoryModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.products,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc, List<ProductModel> productsList) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>? ?? {};
    return CategoryModel(
      id: doc.id,
      name: data['category'] as String? ?? 'Unknown Category',
      nameAr: data['category_ar'] as String? ?? '',
      products: productsList,
    );
  }
}

