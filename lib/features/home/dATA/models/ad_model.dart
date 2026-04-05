import 'package:cloud_firestore/cloud_firestore.dart';

class AdModel {
  final String name;
  final String productPath;
  final String imageUrl;
  final String adDescription;

  AdModel({
    required this.name,
    required this.productPath,
    required this.imageUrl,
    required this.adDescription,
  });

  factory AdModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AdModel(
      name: data['name'] ?? '',
      productPath: data['productPath'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      adDescription: data['ad_description'] ?? '',
    );
  }
}
