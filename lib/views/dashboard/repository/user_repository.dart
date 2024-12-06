import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';

class UserRepository {
  UserRepository._();
  static final i = UserRepository._();
  CollectionReference get user => FirebaseStorageService.i.user;
  CollectionReference get userSubscriptionReceipt =>
      FirebaseStorageService.i.userSubscriptionReceipt;

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

  Future<List<UserIAMModel>> fetchUserFilteredData(String fieldKey,
      List<Map<String, dynamic>> filter, String condition, bool isAsc) async {
    Query query = user;
    List<UserIAMModel> allRes = [];
    if (filter.isEmpty) {
      query = query.orderBy(fieldKey, descending: !isAsc);
    }
    List<UserIAMModel> userList = await getUsers();
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
          case 'array-contains-any': // Array contains any
            if (!allRes.contains(value)) {
              allRes.addAll(userList.where((UserIAMModel e) {
                Map<String, dynamic> json =
                    e.toJson(); // Convert object to JSON
                String? fieldValue =
                    json[field]?.toString(); // Get the dynamic field value
                return fieldValue != null && fieldValue.contains(value);
              }).toList());
            }
            break;
          default:
            break;
        }
      }
    }
    if (condition == "array-contains-any") {
      return allRes;
    } else {
      // Get the filtered query results
      QuerySnapshot querySnapshot = await query.get();
      // Return the matching documents
      return querySnapshot.docs
          .map((e) => UserIAMModel.fromJson(e.data() as Map))
          .toList();
    }
  }
}
