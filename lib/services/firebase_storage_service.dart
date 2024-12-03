import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final i = FirebaseStorageService._();
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  CollectionReference get enterprise => _instance.collection(Env.fbEnterprise);
  CollectionReference get user => _instance.collection(Env.fbUser);
  CollectionReference get circle => _instance.collection(Env.fbCircle);
  CollectionReference get userSubscriptionReceipt =>
      _instance.collection(Env.fbUserSubscriptionReceipt);

  Future<List<EnterpriseModel>> getEnterprises() async {
    QuerySnapshot<Object?> ent = await enterprise.get();
    final List<EnterpriseModel> enterprises = ent.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return EnterpriseModel.fromJson(data);
    }).toList();
    enterprises.sort((a, b) => DateTime.parse(b.mqsCreatedTimestamp)
        .compareTo(DateTime.parse(a.mqsCreatedTimestamp)));
    return enterprises;
  }

  Future<List<EnterpriseModel>> fetchFilteredData(String fieldKey,
      List<Map<String, dynamic>> filter, String condition, bool isAsc) async {
    Query query = enterprise;
    List<EnterpriseModel> allRes = [];
    if (filter.isEmpty) {
      query = query.orderBy(fieldKey, descending: !isAsc);
    }

    List<EnterpriseModel> enterpriseList =
        await FirebaseStorageService.i.getEnterprises();

    for (Map<String, dynamic> filter in filter) {
      String field = filter['field'];
      dynamic condition = filter['condition'];
      if (condition is Map<String, dynamic>) {
        String operator = condition['operator'];
        dynamic type = condition['type'];
        dynamic value = condition['value'];
        switch (operator) {
          case '==': // Equal to
            query = query
                .where(field,
                    isEqualTo: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '!=': // Not equal to
            query = query
                .where(field,
                    isNotEqualTo: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '>': // Greater than
            query = query
                .where(field,
                    isGreaterThan: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '>=': // Greater than or equal to
            query = query
                .where(field,
                    isGreaterThanOrEqualTo:
                        type == StringConfig.dashboard.boolean
                            ? value == 'true'
                            : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '<': // Less than
            query = query
                .where(field,
                    isLessThan: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '<=': // Less than or equal to
            query = query
                .where(field,
                    isLessThanOrEqualTo: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;

          case 'array-contains-any': // Array contains any
            allRes = enterpriseList
                .where((e) => e.toJson().toString().contains(value))
                .toList();

            break;
          default:
            break;
        }
      }
    }
    if (condition == "array-contains-any") {
      return allRes;
    } else {
      QuerySnapshot querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return EnterpriseModel.fromJson(data);
      }).toList();
    }
    // // Get the filtered query results
    // QuerySnapshot querySnapshot = await query.get();
    // // Return the matching documents
    // // return querySnapshot.docs.map((doc) {
    // //   final data = doc.data() as Map<String, dynamic>;
    // //   return EnterpriseModel.fromJson(data);
    // // }).toList();
    // return allRes;
  }

  Future<List<UserIAMModel>> fetchUserFilteredData(String fieldKey,
      List<Map<String, dynamic>> filter, String condition, bool isAsc) async {
    Query query = user;
    if (filter.isEmpty) {
      query = query.orderBy(fieldKey, descending: !isAsc);
    }
    for (Map<String, dynamic> filter in filter) {
      String field = filter['field'];
      var condition = filter['condition'];
      if (condition is Map<String, dynamic>) {
        String operator = condition['operator'];
        dynamic type = condition['type'];
        dynamic value = condition['value'];
        switch (operator) {
          case '==': // Equal to
            query = query
                .where(field,
                    isEqualTo: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '!=': // Not equal to
            query = query
                .where(field,
                    isNotEqualTo: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '>': // Greater than
            query = query
                .where(field,
                    isGreaterThan: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '>=': // Greater than or equal to
            query = query
                .where(field,
                    isGreaterThanOrEqualTo:
                        type == StringConfig.dashboard.boolean
                            ? value == 'true'
                            : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '<': // Less than
            query = query
                .where(field,
                    isLessThan: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '<=': // Less than or equal to
            query = query
                .where(field,
                    isLessThanOrEqualTo: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case 'in': // In array
            query = query.where(field, whereIn: [value.toString()]);
            break;
          case 'array-contains': // Array contains
            query = query.where(field, arrayContains: value);
            break;
          case 'array-contains-any': // Array contains any
            query = query.where(field, arrayContainsAny: [value.toString()]);
            break;
          default:
            break;
        }
      }
    }
    // Get the filtered query results
    QuerySnapshot querySnapshot = await query.get();
    // Return the matching documents
    return querySnapshot.docs
        .map((e) => UserIAMModel.fromJson(e.data() as Map))
        .toList();
  }

  Stream<List<EnterpriseModel>> getEnterpriseStream() {
    return enterprise.snapshots().map((snapshot) {
      List<EnterpriseModel> entList = snapshot.docs
          .map((doc) =>
              EnterpriseModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      entList.sort((a, b) => DateTime.parse(b.mqsCreatedTimestamp)
          .compareTo(DateTime.parse(a.mqsCreatedTimestamp)));
      return entList;
    });
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
    QuerySnapshot<Object?> users = await user.get();
    List<UserIAMModel> userList =
        users.docs.map((e) => UserIAMModel.fromJson(e.data() as Map)).toList();
    userList.sort((a, b) => DateTime.parse(b.mqsCreatedTimestamp)
        .compareTo(DateTime.parse(a.mqsCreatedTimestamp)));
    return userList;
  }

  Stream<List<UserIAMModel>> getUserStream() {
    return user.snapshots().map((snapshot) {
      List<UserIAMModel> userList = snapshot.docs
          .map((doc) =>
              UserIAMModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      userList.sort((a, b) => DateTime.parse(b.mqsCreatedTimestamp)
          .compareTo(DateTime.parse(a.mqsCreatedTimestamp)));
      return userList;
    });
  }

  Future<List<CircleModel>> getCircles() async {
    QuerySnapshot<Object?> cir = await circle.get();
    List<CircleModel> cirList = cir.docs
        .map((e) => CircleModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return cirList;
  }

  Stream<List<CircleModel>> getCircleStream() {
    return circle.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
              (doc) => CircleModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<UserSubscriptionReceiptModel>>
      getUserSubscriptionReceipt() async {
    QuerySnapshot<Object?> receipt = await userSubscriptionReceipt.get();
    List<UserSubscriptionReceiptModel> receiptList = receipt.docs
        .map((e) => UserSubscriptionReceiptModel.fromJson(
            e.data() as Map<String, dynamic>))
        .toList();
    return receiptList;
  }

  Stream<List<UserSubscriptionReceiptModel>>
      getUserSubscriptionReceiptStream() {
    return userSubscriptionReceipt.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserSubscriptionReceiptModel.fromJson(
              doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
