import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/favorites_item_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState.initial());

  void addItem(FavoritesItemModel item) {
    if (!isItemFavorited(item.id)) {
      final updatedItems = List<FavoritesItemModel>.from(state.items)..add(item);
      emit(state.copyWith(items: updatedItems));
    }
  }

  void removeItem(String id) {
    final updatedItems = state.items.where((i) => i.id != id).toList();
    emit(state.copyWith(items: updatedItems));
  }
  
  void toggleFavorite(FavoritesItemModel item) {
    if (isItemFavorited(item.id)) {
      removeItem(item.id);
    } else {
      addItem(item);
    }
  }

  bool isItemFavorited(String id) {
    return state.items.any((i) => i.id == id);
  }
}
