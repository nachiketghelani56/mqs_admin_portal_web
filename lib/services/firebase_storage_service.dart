import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final i = FirebaseStorageService._();
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  CollectionReference get enterprise => _instance.collection(Env.fbEnterprise);
  CollectionReference get user => _instance.collection(Env.fbUser);
  CollectionReference get circle => _instance.collection(Env.fbCircle);

  Future<List<EnterpriseModel>> getEnterprises() async {
    QuerySnapshot<Object?> ent = await enterprise.get();
    List<EnterpriseModel> entList =
        ent.docs.map((e) => EnterpriseModel.fromJson(e.data() as Map)).toList();
    return entList;
  }

  listenToEnterpriseChange(Function(QuerySnapshot<Object?>)? onData) {
    enterprise.snapshots().listen((onData));
  }

  Future<DocumentReference<Object?>> addEnterprises(
      {required EnterpriseModel model}) async {
    DocumentReference<Object?> doc = await enterprise.add(model.toJson());
    await enterprise.doc(doc.id).update({'_id': doc.id});
    return doc;
  }

  Future editEnterprises({required EnterpriseModel model}) async {
    await enterprise.doc(model.id).update(model.toJson());
  }

  Future deleteEnterprises({required String docId}) async {
    await enterprise.doc(docId).delete();
  }

  Future<List<UserIAMModel>> getUsers() async {
    QuerySnapshot<Object?> ent = await user.get();
    List<UserIAMModel> userList =
        ent.docs.map((e) => UserIAMModel.fromJson(e.data() as Map)).toList();
    return userList;
  }

  listenToUserChange(Function(QuerySnapshot<Object?>)? onData) {
    user.snapshots().listen((onData));
  }

  Future<List<CircleModel>> getCircles() async {
    QuerySnapshot<Object?> cir = await circle.get();
    List<CircleModel> cirList = cir.docs
        .map((e) => CircleModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return cirList;
  }

  listenToCircleChange(Function(QuerySnapshot<Object?>)? onData) {
    circle.snapshots().listen((onData));
  }
}
