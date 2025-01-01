import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add  by own id or Update User Data
  Future<void> setData(
      {required String collection,
      String? documentId,
      required Map<String, dynamic> data}) async {
    try {
      await _firestore
          .collection(collection)
          .doc(documentId)
          .set(data, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error setting data: $e');
    }
  }

  // Get Document Data
  Future<DocumentSnapshot> getData(
      {required String collection, required String documentId}) async {
    try {
      return await _firestore.collection(collection).doc(documentId).get();
    } catch (e) {
      throw Exception('Error getting data: $e');
    }
  }

  // Update Document Data
  Future<void> updateData(
      {required String collection,
      required String documentId,
      required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(data);
    } catch (e) {
      throw Exception('Error updating data: $e');
    }
  }

  // Delete Document Data
  Future<void> deleteData(
      {required String collection, required String documentId}) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }

  String getFirebaseUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('No user is currently signed in.');
    }
  }

  // Get All Documents from a Collection
  Future<QuerySnapshot> getAllDocuments({required String collection}) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collection).get();
      return querySnapshot;
    } catch (e) {
      throw Exception('Error getting documents: $e');
    }
  }

  //get documnt with condition
  CollectionReference getAllDocumentsWithCondition(
      {required String collection}) {
    return FirebaseFirestore.instance.collection(collection);
  }

  // Listen to Realtime Updates on a Document
  Stream<DocumentSnapshot> listenToDocument(
      {required String collection, required String documentId}) {
    try {
      return _firestore.collection(collection).doc(documentId).snapshots();
    } catch (e) {
      throw Exception('Error listening to document: $e');
    }
  }

  Future<bool> checkIsExist(
      {required String path, required String docId}) async {
    var data = await _firestore.collection(path).doc(docId).get();
    return data.exists;
  }

  //get current user
}


/**
 * If merge: true is used: Only the fields in data will be updated or added without affecting the other existing fields in the document.
 */