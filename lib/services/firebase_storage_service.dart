import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final i = FirebaseStorageService._();
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  CollectionReference get enterprise => _instance.collection(Env.fbEnterprise);
  CollectionReference get user => _instance.collection(Env.fbUser);
  CollectionReference get circle => _instance.collection(Env.fbCircle);

  Future<List<EnterpriseModel>> getEnterprises() async {
    QuerySnapshot<Object?> ent = await enterprise.get();

    final List<EnterpriseModel> enterprises = ent.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return EnterpriseModel.fromJson(data);
    }).toList();

    return enterprises;
  }

  Stream<List<EnterpriseModel>> getEnterpriseStream() {
    return enterprise.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              EnterpriseModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  listenToEnterpriseChange(Function(QuerySnapshot<Object?>)? onData) {
    enterprise.snapshots().listen((onData));
  }

  Future<void> editEnterprises(
      {required String docId, required EnterpriseModel enterprise}) async {
    try {
      await FirebaseStorageService.i.enterprise
          .doc(docId)
          .set(enterprise.toJson(), SetOptions(merge: true));
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    }
  }

  Future<void> addEnterprises(
      {required EnterpriseModel enterprise, required String customId}) async {
    await FirebaseStorageService.i.enterprise.doc(customId).set({
      ...enterprise.toJson(),
    });
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

  Stream<List<UserIAMModel>> getUserStream() {
    return user.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              UserIAMModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
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
