class FavoritesItemModel {
  final String id;
  final String title;
  final String titleAr;
  final String description;
  final String descriptionAr;
  final double price;
  final String imageUrl;

  FavoritesItemModel({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.description,
    required this.descriptionAr,
    required this.price,
    required this.imageUrl,
  });

  FavoritesItemModel copyWith({
    String? id,
    String? title,
    String? titleAr,
    String? description,
    String? descriptionAr,
    double? price,
    String? imageUrl,
  }) {
    return FavoritesItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
