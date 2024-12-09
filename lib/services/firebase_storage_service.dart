import 'package:cloud_firestore/cloud_firestore.dart';
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

  FirebaseFirestore get contentPortalInstance => FirebaseFirestore.instanceFor(
      app: _instance.app, databaseId: Env.fbDatabseId);
  CollectionReference get pathway =>
      contentPortalInstance.collection(Env.fbPathway);
}
