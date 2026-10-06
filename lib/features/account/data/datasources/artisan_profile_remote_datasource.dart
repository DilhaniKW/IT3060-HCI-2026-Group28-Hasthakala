import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/shared_models/artisan_profile_model.dart';

// I05 manage profile - reads and updates artisanProfiles/{uid}
class ArtisanProfileRemoteDataSource {
  final FirebaseFirestore _db;

  ArtisanProfileRemoteDataSource({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _db.collection(FirestoreCollections.artisanProfiles).doc(uid);

  Stream<ArtisanProfileModel?> watchProfile(String uid) {
    return _doc(uid).snapshots().map((d) =>
        d.exists && d.data() != null ? ArtisanProfileModel.fromMap(d.data()!, d.id) : null);
  }

  // only the editable fields are sent - verified can't be changed by the artisan
  Future<void> updateProfile(ArtisanProfileModel profile) async {
    await _doc(profile.artisanUid).update({
      'displayName': profile.displayName,
      'craftType': profile.craftType,
      'about': profile.about,
      'location': profile.location,
      'updatedAt': Timestamp.now(),
    });

    // products keep a copy of the artisan name, so keep it in sync
    final products = await _db
        .collection(FirestoreCollections.products)
        .where('artisanId', isEqualTo: profile.artisanUid)
        .get();
    if (products.docs.isEmpty) return;
    final batch = _db.batch();
    for (final p in products.docs) {
      batch.update(p.reference, {'artisanName': profile.displayName});
    }
    await batch.commit();
  }
}
