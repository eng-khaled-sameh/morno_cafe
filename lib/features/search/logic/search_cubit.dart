import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/features/home/logic/home_cubit.dart';
import 'package:caffe_app/features/home/logic/home_state.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeCubit _homeCubit;
  String _currentQuery = '';
  String? _currentCategoryId;

  SearchCubit(this._homeCubit) : super(SearchInitial());

  void search(String query, {String? categoryId, bool retainQuery = false}) {
    if (!retainQuery) {
      _currentQuery = query;
    }
    if (categoryId != null) {
      _currentCategoryId = categoryId == 'all' ? null : categoryId;
    }

    if (_currentQuery.trim().isEmpty) {
      _currentCategoryId = null;
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final homeState = _homeCubit.state;
    if (homeState is HomeSuccess) {
      final categories = homeState.categories;
      
      // Flatten products list mapping back out
      List<ProductModel> allProducts = [];
      for (var category in categories) {
        if (_currentCategoryId != null && category.id != _currentCategoryId) {
          continue;
        }
        allProducts.addAll(category.products);
      }

      // Filter by query
      if (_currentQuery.isNotEmpty) {
        final queryLower = _currentQuery.toLowerCase();
        allProducts = allProducts.where((p) {
          return p.name.toLowerCase().contains(queryLower) ||
                 p.subtitle.toLowerCase().contains(queryLower);
        }).toList();
      }

      if (allProducts.isEmpty) {
        emit(SearchEmpty(activeCategoryId: _currentCategoryId));
      } else {
        emit(SearchSuccess(allProducts, activeCategoryId: _currentCategoryId));
      }
    } else {
      emit(SearchInitial());
    }
  }

  void clearSearch() {
    _currentQuery = '';
    _currentCategoryId = null;
    emit(SearchInitial());
  }
}

