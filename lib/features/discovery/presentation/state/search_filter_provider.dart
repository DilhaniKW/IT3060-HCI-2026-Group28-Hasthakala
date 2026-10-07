import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/shared_models/product_model.dart';
import '../../data/datasources/discovery_remote_datasource.dart';
import '../../data/discovery_filters.dart';

typedef DiscoverySearch = Future<List<ProductModel>> Function({
  String? query,
  String? category,
  String? district,
  double? maxPrice,
});

class SearchFilterProvider extends ChangeNotifier {
  SearchFilterProvider(
      {DiscoveryRemoteDataSource? dataSource, DiscoverySearch? search})
      : _search = search ??
            (dataSource ?? DiscoveryRemoteDataSource()).searchProducts;

  final DiscoverySearch _search;
  List<ProductModel> _searchResults = [];
  bool _isSearching = false;
  bool _disposed = false;
  int _request = 0;
  Timer? _debounce;
  String _query = '';
  String? _selectedCategory;
  String? _selectedDistrict;
  double? _maxPrice;
  String? _errorMessage;

  List<ProductModel> get searchResults => List.unmodifiable(_searchResults);
  bool get isSearching => _isSearching;
  String get query => _query;
  String? get selectedCategory => _selectedCategory;
  String? get selectedDistrict => _selectedDistrict;
  double? get maxPrice => _maxPrice;
  String? get errorMessage => _errorMessage;
  bool get hasFilters =>
      _selectedCategory != null ||
      _selectedDistrict != null ||
      _maxPrice != null;

  void updateQuery(String value) {
    _query = value;
    _debounce?.cancel();
    ++_request;
    _isSearching = true;
    _errorMessage = null;
    notifyListeners();
    _debounce = Timer(const Duration(milliseconds: 300), performSearch);
  }

  Future<void> setCategory(String? category) => applyFilters(
      category: category, district: _selectedDistrict, maxPrice: _maxPrice);

  Future<void> applyFilters(
      {String? category, String? district, double? maxPrice}) {
    _selectedCategory = discoveryCategoryKey(category);
    _selectedDistrict = district;
    _maxPrice = maxPrice;
    return performSearch();
  }

  Future<void> clearFilters() => applyFilters();

  Future<void> performSearch({String? query}) async {
    if (_disposed) return;
    _debounce?.cancel();
    if (query != null) _query = query;
    final request = ++_request;
    _isSearching = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final results = await _search(
          query: _query.trim(),
          category: _selectedCategory,
          district: _selectedDistrict,
          maxPrice: _maxPrice);
      if (_disposed || request != _request) return;
      _searchResults = results;
    } catch (_) {
      if (_disposed || request != _request) return;
      _searchResults = [];
      _errorMessage =
          'Could not load crafts. Check your connection and try again.';
    } finally {
      if (!_disposed && request == _request) {
        _isSearching = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _debounce?.cancel();
    super.dispose();
  }
}
