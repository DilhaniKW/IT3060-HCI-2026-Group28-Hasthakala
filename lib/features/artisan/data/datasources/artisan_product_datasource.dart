import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../../core/services/firebase/storage_service.dart';
import '../../../../core/shared_models/product_model.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanProductDataSource {
  final FirestoreService _firestoreService;
  final StorageService _storageService;

  ArtisanProductDataSource({
    FirestoreService? firestoreService,
    StorageService? storageService,
  })  : _firestoreService = firestoreService ?? FirestoreService(),
        _storageService = storageService ?? StorageService();

  Stream<List<ProductModel>> getArtisanProducts(String artisanId) {
    return _firestoreService
        .streamCollection(
          collection: FirestoreCollections.products,
          queryBuilder: (q) => q.where('artisanId', isEqualTo: artisanId),
        )
        .map((snapshot) =>
            snapshot.docs.map((doc) => ProductModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> createProduct(ProductModel product) async {
    await _firestoreService.addDocument(
      collection: FirestoreCollections.products,
      data: product.toMap(),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await _firestoreService.setDocument(
      collection: FirestoreCollections.products,
      docId: product.id,
      data: product.toMap(),
    );
  }

  Future<void> deleteProduct(String productId) async {
    await _firestoreService.deleteDocument(
      collection: FirestoreCollections.products,
      docId: productId,
    );
  }
}
