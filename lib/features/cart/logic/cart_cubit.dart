import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/cart_item_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  void clearCart() {
    emit(CartState.initial());
  }

  void addItem(CartItemModel item) {
    final existingIndex =
        state.items.indexWhere((i) => i.id == item.id && i.size == item.size);
    List<CartItemModel> updatedItems = List.from(state.items);

    if (existingIndex != -1) {
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + 1,
      );
    } else {
      updatedItems.add(item);
    }

    _updateCart(updatedItems);
  }

  /// Updates line item size and unit [price] for the row matching [id] + [oldSize].
  void updateItemSize(String id, String oldSize, String newSize) {
    final index =
        state.items.indexWhere((i) => i.id == id && i.size == oldSize);
    if (index == -1) return;

    final item = state.items[index];
    final newPrice = item.priceForSize(newSize);
    final updatedItems = List<CartItemModel>.from(state.items);
    updatedItems[index] = item.copyWith(size: newSize, price: newPrice);
    _updateCart(updatedItems);
  }

  void incrementQuantity(String id, String size) {
    final index = state.items.indexWhere((i) => i.id == id && i.size == size);
    if (index != -1) {
      List<CartItemModel> updatedItems = List.from(state.items);
      updatedItems[index] = updatedItems[index].copyWith(
        quantity: updatedItems[index].quantity + 1,
      );
      _updateCart(updatedItems);
    }
  }

  void decrementQuantity(String id, String size) {
    final index = state.items.indexWhere((i) => i.id == id && i.size == size);
    if (index != -1) {
      List<CartItemModel> updatedItems = List.from(state.items);
      if (updatedItems[index].quantity > 1) {
        updatedItems[index] = updatedItems[index].copyWith(
          quantity: updatedItems[index].quantity - 1,
        );
        _updateCart(updatedItems);
      } else {
        removeItem(id, size);
      }
    }
  }

  void removeItem(String id, String size) {
    final updatedItems = state.items
        .where((i) => !(i.id == id && i.size == size))
        .toList();
    _updateCart(updatedItems);
  }

  void updateNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  void _updateCart(List<CartItemModel> items) {
    double subtotal = 0;
    for (var item in items) {
      subtotal += item.price * item.quantity;
    }

    double deliveryFee = items.isEmpty ? 0.0 : 2.0;

    emit(
      state.copyWith(
        items: items,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        total: subtotal + deliveryFee,
      ),
    );
  }
}
