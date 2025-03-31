import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- Users ---
  Future<void> createUser(String uid, String email, String fullName) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'fullName': fullName,
      'role': 'customer',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<Map<String, dynamic>?> getUser(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    return doc.data() as Map<String, dynamic>?;
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).delete();
  }

  // --- Products ---
  Future<void> addProduct(Map<String, dynamic> product) async {
    await _db.collection('products').add(product);
  }

  Stream<QuerySnapshot> getProducts() {
    return _db.collection('products').snapshots();
  }

  Future<Map<String, dynamic>?> getProduct(String productId) async {
    DocumentSnapshot doc = await _db.collection('products').doc(productId).get();
    return doc.data() as Map<String, dynamic>?;
  }

  Future<void> updateProduct(String productId, Map<String, dynamic> data) async {
    await _db.collection('products').doc(productId).update(data);
  }

  Future<void> deleteProduct(String productId) async {
    await _db.collection('products').doc(productId).delete();
  }

  // --- Orders ---
  Future<String> createOrder(Map<String, dynamic> order) async {
    DocumentReference ref = await _db.collection('orders').add(order);
    return ref.id; // Return orderId for navigation
  }

  Stream<QuerySnapshot> getOrders(String userId) {
    return _db.collection('orders').where('userId', isEqualTo: userId).snapshots();
  }

  Future<Map<String, dynamic>?> getOrder(String orderId) async {
    DocumentSnapshot doc = await _db.collection('orders').doc(orderId).get();
    return doc.data() as Map<String, dynamic>?;
  }

  Future<void> updateOrder(String orderId, Map<String, dynamic> data) async {
    await _db.collection('orders').doc(orderId).update(data);
  }

  // --- Shipping Addresses ---
  Future<String> addShippingAddress(String userId, Map<String, dynamic> address) async {
    DocumentReference ref = await _db.collection('shipping_addresses').add({
      'userId': userId,
      ...address,
    });
    return ref.id;
  }

  Stream<QuerySnapshot> getShippingAddresses(String userId) {
    return _db.collection('shipping_addresses').where('userId', isEqualTo: userId).snapshots();
  }

  // --- Categories ---
  Future<void> addCategory(Map<String, dynamic> category) async {
    await _db.collection('categories').add(category);
  }

  Stream<QuerySnapshot> getCategories() {
    return _db.collection('categories').snapshots();
  }
}