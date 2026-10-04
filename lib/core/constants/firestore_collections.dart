/// Centralized Firestore collection and document field references
/// To be used by all team members to avoid string typos across branches.
class FirestoreCollections {
  // Collection Names
  static const String users = 'users';
  static const String products = 'products';
  static const String orders = 'orders';
  static const String carts = 'carts';
  static const String chats = 'chats';
  static const String messages = 'messages';
  static const String categories = 'categories';
  static const String reviews = 'reviews';
  static const String familyPermissions = 'family_permissions';

  // Sub-collection helpers
  static String userCart(String userId) => '$users/$userId/cart_items';
  static String chatMessages(String chatId) => '$chats/$chatId/messages';
  static String productReviews(String productId) => '$products/$productId/reviews';
}
