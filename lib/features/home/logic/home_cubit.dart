import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/core/services/firestore_service.dart';
import 'package:caffe_app/features/home/data/models/category_model.dart';
import 'package:caffe_app/features/home/data/models/ad_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirestoreService _service = FirestoreService();

  HomeCubit() : super(HomeInitial()) {
    getCategories();
  }

  Future<void> getCategories() async {
    if (state is HomeSuccess) return;
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        _service.getCategories(),
        _service.getAds(),
      ]);
      emit(HomeSuccess(
        categories: results[0] as List<CategoryModel>,
        ads: results[1] as List<AdModel>,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

