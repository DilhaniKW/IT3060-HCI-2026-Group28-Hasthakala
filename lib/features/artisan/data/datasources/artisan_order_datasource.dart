import '../../../core/constants/firestore_collections.dart';
import '../../../core/services/firebase/firestore_service.dart';
import '../../../core/shared_models/order_model.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanOrderDataSource {
  final FirestoreService _firestoreService;

  ArtisanOrderDataSource({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  Stream<List<OrderModel>> getIncomingOrders() {
    return _firestoreService
        .streamCollection(collection: FirestoreCollections.orders)
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await _firestoreService.setDocument(
      collection: FirestoreCollections.orders,
      docId: orderId,
      data: {'status': status.name},
      merge: true,
    );
  }
}
