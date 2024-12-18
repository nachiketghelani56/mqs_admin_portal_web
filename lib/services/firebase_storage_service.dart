import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final i = FirebaseStorageService._();
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  CollectionReference get enterprise => _instance.collection(Env.fbEnterprise);
  CollectionReference get user => _instance.collection(Env.fbUser);
  CollectionReference get circle => _instance.collection(Env.fbCircle);
  CollectionReference get userSubscriptionReceipt =>
      _instance.collection(Env.fbUserSubscriptionReceipt);

  // FirebaseFirestore get contentPortalInstance => FirebaseFirestore.instanceFor(
  //     app: _instance.app, databaseId: Env.fbDatabseId);
  CollectionReference get pathway => _instance.collection(Env.fbPathway);

  Future<String> uploadFile(
      {required Uint8List data, String ext = 'jpg'}) async {
    // Define a unique file name
    String fileName =
        '${Env.fbPathway}/${DateTime.now().millisecondsSinceEpoch}.$ext';
    // Reference to Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child(fileName);
    // Upload the file
    final uploadTask = await storageRef.putData(data);
    // Get the download URL
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteFile({required String downloadURL}) async {
    Uri uri = Uri.parse(downloadURL);
    // Get file path from download URL
    String fullPath = uri.pathSegments.last.split("?").first;
    // Reference to the file in Firebase Storage
    final storageRef = FirebaseStorage.instance.ref().child(fullPath);
    // Delete the file
    await storageRef.delete();
  }
}
