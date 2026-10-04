import 'package:flutter/material.dart';
import '../../../core/shared_models/user_model.dart';
import '../../data/datasources/auth_remote_datasource.dart';

/// Assigned to: WANIGATHUNGA Y. J.
/// Branch: feature/account-support
class AuthProvider extends ChangeNotifier {
  final AuthRemoteDataSource _authDataSource;

  AuthProvider({AuthRemoteDataSource? authDataSource})
      : _authDataSource = authDataSource ?? AuthRemoteDataSource();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authDataSource.login(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
    String? district,
    bool isFamilyAssisted = false,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authDataSource.register(
        email: email,
        password: password,
        displayName: displayName,
        role: role,
        district: district,
        isFamilyAssisted: isFamilyAssisted,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authDataSource.logout();
    _currentUser = null;
    notifyListeners();
  }
}
