import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caffe_app/features/home/data/models/category_model.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/features/home/data/models/ad_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    try {
      QuerySnapshot categorySnapshot = await _firestore
          .collection('categories')
          .get();

      final futures = categorySnapshot.docs.map((categoryDoc) async {
        final results = await Future.wait([
          categoryDoc.reference.collection('products_size').get(),
          categoryDoc.reference.collection('product_Portion').get(),
        ]);

        final sizeProducts = results[0].docs
            .map((d) => ProductModel.fromFirestore(d, source: 'products_size'))
            .toList();

        final portionProducts = results[1].docs
            .map((d) => ProductModel.fromFirestore(d, source: 'product_Portion'))
            .toList();

        final category = CategoryModel.fromFirestore(
          categoryDoc,
          [...sizeProducts, ...portionProducts],
        );
        return category;
      });

      categories = await Future.wait(futures);
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }

    return categories;
  }

  Future<List<AdModel>> getAds() async {
    List<AdModel> ads = [];
    try {
      QuerySnapshot adSnapshot = await _firestore.collection('ad').get();
      ads = adSnapshot.docs.map((doc) => AdModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch ads: $e');
    }
    return ads;
  }

  Future<ProductModel?> getProductByPath(String path) async {
    try {
      final doc = await FirebaseFirestore.instance.doc(path).get();
      if (doc.exists) {
        final source = path.contains('product_Portion')
            ? 'product_Portion'
            : 'products_size';
        return ProductModel.fromFirestore(doc, source: source);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

