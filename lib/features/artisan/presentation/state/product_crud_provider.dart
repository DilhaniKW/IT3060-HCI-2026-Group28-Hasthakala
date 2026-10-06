import 'package:flutter/material.dart';
import '../../../../core/shared_models/product_model.dart';
import '../../data/datasources/artisan_product_datasource.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ProductCrudProvider extends ChangeNotifier {
  final ArtisanProductDataSource _dataSource;

  ProductCrudProvider({ArtisanProductDataSource? dataSource})
      : _dataSource = dataSource ?? ArtisanProductDataSource();

  bool _isSaving = false;
  String? _errorMessage;

  bool get isSaving => _isSaving;
  String? get errorMessage => _errorMessage;

  Future<bool> saveProduct(ProductModel product, {bool isEditing = false}) async {
    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (isEditing) {
        await _dataSource.updateProduct(product);
      } else {
        await _dataSource.createProduct(product);
      }
      _isSaving = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isSaving = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> removeProduct(String productId) async {
    await _dataSource.deleteProduct(productId);
  }
}
