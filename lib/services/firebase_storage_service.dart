import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final i = FirebaseStorageService._();
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  CollectionReference get enterprise => _instance.collection(Env.fbEnterprise);
  CollectionReference get user => _instance.collection(Env.fbUser);

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
}
