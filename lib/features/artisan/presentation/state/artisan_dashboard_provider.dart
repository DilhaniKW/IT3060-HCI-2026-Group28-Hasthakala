import 'package:flutter/material.dart';
import '../../../core/shared_models/product_model.dart';
import '../../data/datasources/artisan_product_datasource.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanDashboardProvider extends ChangeNotifier {
  final ArtisanProductDataSource _productDataSource;

  ArtisanDashboardProvider({ArtisanProductDataSource? productDataSource})
      : _productDataSource = productDataSource ?? ArtisanProductDataSource();

  List<ProductModel> _myProducts = [];
  bool _isLoading = false;

  List<ProductModel> get myProducts => _myProducts;
  bool get isLoading => _isLoading;

  int get totalListings => _myProducts.length;
  int get activeListings => _myProducts.where((p) => p.isAvailable).length;

  void listenToArtisanProducts(String artisanId) {
    _isLoading = true;
    notifyListeners();

    _productDataSource.getArtisanProducts(artisanId).listen((items) {
      _myProducts = items;
      _isLoading = false;
      notifyListeners();
    });
  }
}
