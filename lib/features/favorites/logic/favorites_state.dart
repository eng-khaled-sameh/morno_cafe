import '../data/models/favorites_item_model.dart';

class FavoritesState {
  final List<FavoritesItemModel> items;

  FavoritesState({required this.items});

  factory FavoritesState.initial() {
    return FavoritesState(items: []);
  }

  FavoritesState copyWith({
    List<FavoritesItemModel>? items,
  }) {
    return FavoritesState(
      items: items ?? this.items,
    );
  }
}
