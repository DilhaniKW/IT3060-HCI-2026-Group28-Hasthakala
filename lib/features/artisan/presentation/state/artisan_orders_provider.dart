import 'package:flutter/material.dart';
import '../../../core/shared_models/order_model.dart';
import '../../data/datasources/artisan_order_datasource.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanOrdersProvider extends ChangeNotifier {
  final ArtisanOrderDataSource _dataSource;

  ArtisanOrdersProvider({ArtisanOrderDataSource? dataSource})
      : _dataSource = dataSource ?? ArtisanOrderDataSource();

  List<OrderModel> _incomingOrders = [];
  bool _isLoading = false;

  List<OrderModel> get incomingOrders => _incomingOrders;
  bool get isLoading => _isLoading;

  void listenToOrders() {
    _isLoading = true;
    notifyListeners();

    _dataSource.getIncomingOrders().listen((orders) {
      _incomingOrders = orders;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> changeOrderStatus(String orderId, OrderStatus status) async {
    await _dataSource.updateOrderStatus(orderId, status);
  }
}
