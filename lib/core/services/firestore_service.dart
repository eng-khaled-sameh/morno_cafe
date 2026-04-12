import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caffe_app/features/home/data/models/category_model.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/features/home/data/models/ad_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<double> getCanPrice() async {
    try {
      final doc = await _firestore.doc('addition/can').get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return double.tryParse(data['can_price']?.toString() ?? '0.0') ?? 0.0;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    try {
      final results = await Future.wait([
        _firestore.collection('categories').get(),
        getCanPrice(),
      ]);

      final categorySnapshot = results[0] as QuerySnapshot;
      final canPrice = results[1] as double;

      final futures = categorySnapshot.docs.map((categoryDoc) async {
        final categoryId = categoryDoc.id;
        final productResults = await Future.wait([
          categoryDoc.reference.collection('products_size').get(),
          categoryDoc.reference.collection('product_Portion').get(),
        ]);

        final sizeProducts = (productResults[0] as QuerySnapshot)
            .docs
            .map((d) => ProductModel.fromFirestore(
                  d,
                  source: 'products_size',
                  categoryId: categoryId,
                  canPrice: canPrice,
                ))
            .toList();

        final portionProducts = (productResults[1] as QuerySnapshot)
            .docs
            .map((d) => ProductModel.fromFirestore(
                  d,
                  source: 'product_Portion',
                  categoryId: categoryId,
                  canPrice: canPrice,
                ))
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
      final results = await Future.wait([
        _firestore.doc(path).get(),
        getCanPrice(),
      ]);
      final doc = results[0] as DocumentSnapshot;
      final canPrice = results[1] as double;

      if (doc.exists) {
        final source = path.contains('product_Portion')
            ? 'product_Portion'
            : 'products_size';
        
        // Extract categoryId from path: categories/{categoryId}/products_size/{productId}
        final pathSegments = path.split('/');
        String categoryId = '';
        if (pathSegments.length >= 2 && pathSegments[0] == 'categories') {
          categoryId = pathSegments[1];
        }

        return ProductModel.fromFirestore(
          doc,
          source: source,
          categoryId: categoryId,
          canPrice: canPrice,
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}


