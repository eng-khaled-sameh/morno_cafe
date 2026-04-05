import '../data/models/cart_item_model.dart';

class CartState {
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String notes;

  CartState({
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.notes,
  });

  factory CartState.initial() {
    return CartState(
      items: [],
      subtotal: 0.0,
      deliveryFee: 2.0,
      total: 2.0,
      notes: '',
    );
  }

  CartState copyWith({
    List<CartItemModel>? items,
    double? subtotal,
    double? deliveryFee,
    double? total,
    String? notes,
  }) {
    return CartState(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      notes: notes ?? this.notes,
    );
  }
}
