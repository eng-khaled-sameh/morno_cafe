import 'package:caffe_app/features/home/data/models/category_model.dart';
import 'package:caffe_app/features/home/data/models/ad_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<CategoryModel> categories;
  final List<AdModel> ads;
  HomeSuccess({required this.categories, required this.ads});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

