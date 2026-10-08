import 'package:flutter/material.dart';
import '../../../../core/shared_models/order_model.dart';
import '../../data/datasources/cart_remote_datasource.dart';

/// Assigned to: DISSANAYAKE D. M. S. D.
/// Branch: feature/buyer-purchase
class CartProvider extends ChangeNotifier {
  final CartRemoteDataSource _dataSource;

  CartProvider({CartRemoteDataSource? dataSource})
      : _dataSource = dataSource ?? CartRemoteDataSource() {
    _initSampleItems();
  }

  CartRemoteDataSource get dataSource => _dataSource;

  final List<OrderItemModel> _cartItems = [];
  final bool _isLoading = false;

  List<OrderItemModel> get cartItems => List.unmodifiable(_cartItems);
  bool get isLoading => _isLoading;

  void _initSampleItems() {
    _cartItems.addAll([
      OrderItemModel(
        productId: 'sample_1',
        title: 'Heritage Unglazed Terracotta Jug',
        unitPriceLkr: 2400.0,
        quantity: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&q=80&w=600',
        artisanId: 'artisan_sunil',
      ),
      OrderItemModel(
        productId: 'sample_2',
        title: 'Traditional Gurulu Raksha Mask',
        unitPriceLkr: 3200.0,
        quantity: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1584727638096-042c45049ebe?auto=format&fit=crop&q=80&w=600',
        artisanId: 'artisan_kamal',
      ),
    ]);
  }

  double get subtotalLkr =>
      _cartItems.fold(0.0, (sum, item) => sum + (item.unitPriceLkr * item.quantity));

  double get deliveryFeeLkr => _cartItems.isEmpty ? 0.0 : 450.0; // Flat Rs. 450 islandwide delivery
  double get packagingFeeLkr => _cartItems.isEmpty ? 0.0 : 200.0; // Flat Rs. 200 artisan packaging

  double get totalLkr => subtotalLkr + deliveryFeeLkr + packagingFeeLkr;

  int get totalItemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  void addItem(OrderItemModel item) {
    final index = _cartItems.indexWhere((element) => element.productId == item.productId);
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
    if (newQuantity <= 0) {
      removeItem(productId);
      return;
    }
    final index = _cartItems.indexWhere((element) => element.productId == productId);
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
    notifyListeners();
  }
}
