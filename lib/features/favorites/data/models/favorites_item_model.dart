class FavoritesItemModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  FavoritesItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  FavoritesItemModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
  }) {
    return FavoritesItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
