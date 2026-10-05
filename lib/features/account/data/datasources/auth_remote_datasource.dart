import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/services/firebase/firebase_auth_service.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../../core/shared_models/user_model.dart';

/// Assigned to: WANIGATHUNGA Y. J.
/// Branch: feature/account-support
class AuthRemoteDataSource {
  final FirebaseAuthService _authService;
  final FirestoreService _firestoreService;

  AuthRemoteDataSource({
    FirebaseAuthService? authService,
    FirestoreService? firestoreService,
  })  : _authService = authService ?? FirebaseAuthService(),
        _firestoreService = firestoreService ?? FirestoreService();

  Future<UserModel> login(String email, String password) async {
    final credential = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user!.uid;

    final doc = await _firestoreService.getDocument(
      collection: FirestoreCollections.users,
      docId: uid,
    );

    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }

    throw Exception('User profile not found in Firestore.');
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
    String? district,
    bool isFamilyAssisted = false,
  }) async {
    final credential = await _authService.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user!.uid;

    final newUser = UserModel(
      uid: uid,
      email: email,
      displayName: displayName,
      role: role,
      district: district,
      isFamilyAssisted: isFamilyAssisted,
    );

    await _firestoreService.setDocument(
      collection: FirestoreCollections.users,
      docId: uid,
      data: newUser.toMap(),
    );

    return newUser;
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}
