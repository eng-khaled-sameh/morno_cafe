import 'package:caffe_app/features/home/data/models/product_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductModel> results;
  final String? activeCategoryId;

  SearchSuccess(this.results, {this.activeCategoryId});
}

class SearchEmpty extends SearchState {
  final String? activeCategoryId;

  SearchEmpty({this.activeCategoryId});
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
