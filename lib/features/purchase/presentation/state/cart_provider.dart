import 'package:flutter/material.dart';
import '../../../../core/shared_models/order_model.dart';
import '../../../../core/shared_models/product_model.dart';

/// Assigned to: DISSANAYAKE D. M. S. D.
/// Branch: feature/buyer-purchase
class CartProvider extends ChangeNotifier {
  // This provider owns the current session's cart. Persistence is a separate
  // purchase feature; constructing the local cart does not require Firebase.
  final Map<String, int> _stockLimits = {};

  int quantityFor(String productId) => _cartItems
      .where((item) => item.productId == productId)
      .fold(0, (total, item) => total + item.quantity);

  bool addProduct(ProductModel product, {int quantity = 1}) {
    if (!product.isAvailable ||
        product.stockQuantity <= 0 ||
        quantity <= 0 ||
        quantityFor(product.id) + quantity > product.stockQuantity) {
      return false;
    }
    _stockLimits[product.id] = product.stockQuantity;
    addItem(OrderItemModel(
        productId: product.id,
        title: product.title,
        unitPriceLkr: product.priceLkr,
        quantity: quantity,
        imageUrl: product.imageUrls.isEmpty ? null : product.imageUrls.first,
        artisanId: product.artisanId));
    return true;
  }

  final List<OrderItemModel> _cartItems = [];

  List<OrderItemModel> get cartItems => List.unmodifiable(_cartItems);
  bool get isLoading => false;

  double get subtotalLkr => _cartItems.fold(
      0.0, (sum, item) => sum + (item.unitPriceLkr * item.quantity));

  double get deliveryFeeLkr =>
      _cartItems.isEmpty ? 0.0 : 350.0; // Standard domestic shipping

  double get totalLkr => subtotalLkr + deliveryFeeLkr;

  int get totalItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  void addItem(OrderItemModel item) {
    if (item.quantity <= 0 ||
        (_stockLimits.containsKey(item.productId) &&
            quantityFor(item.productId) + item.quantity >
                _stockLimits[item.productId]!)) {
      return;
    }
    final index =
        _cartItems.indexWhere((element) => element.productId == item.productId);
    if (index >= 0) {
      final existing = _cartItems[index];
      _cartItems[index] = OrderItemModel(
        productId: existing.productId,
        title: existing.title,
        unitPriceLkr: existing.unitPriceLkr,
        quantity: existing.quantity + item.quantity,
        imageUrl: existing.imageUrl,
        artisanId: existing.artisanId,
      );
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (_stockLimits.containsKey(productId) &&
        newQuantity > _stockLimits[productId]!) {
      return;
    }
    if (newQuantity <= 0) {
      removeItem(productId);
      return;
    }
    final index =
        _cartItems.indexWhere((element) => element.productId == productId);
    if (index >= 0) {
      final existing = _cartItems[index];
      _cartItems[index] = OrderItemModel(
        productId: existing.productId,
        title: existing.title,
        unitPriceLkr: existing.unitPriceLkr,
        quantity: newQuantity,
        imageUrl: existing.imageUrl,
        artisanId: existing.artisanId,
      );
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _stockLimits.clear();
    notifyListeners();
  }
}
