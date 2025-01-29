import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class UserRepository {
  UserRepository._();
  static final i = UserRepository._();
  CollectionReference get user => FirebaseStorageService.i.user;
  CollectionReference get userSubscriptionReceipt =>
      FirebaseStorageService.i.userSubscriptionReceipt;

  Future<List<MQSMyQUserIamModel>> getUsers() async {
    QuerySnapshot<Object?> users = await user.get();
    List<MQSMyQUserIamModel> userList = users.docs
        .map((e) =>
            MQSMyQUserIamModel.fromJson(e.data() as Map<String, dynamic>,e.id))
        .toList();
    userList.sort((a, b) => DateTime.parse(
            b.mqsCreatedTimestamp?.isEmpty ?? false
                ? DateTime.now().toIso8601String()
                : b.mqsCreatedTimestamp ?? "")
        .compareTo(DateTime.parse(a.mqsCreatedTimestamp?.isEmpty ?? false
            ? DateTime.now().toIso8601String()
            : a.mqsCreatedTimestamp ?? "")));
    return userList;
  }

  Stream<List<MQSMyQUserIamModel>> getUserStream() {
    return user.snapshots().map((snapshot) {
      List<MQSMyQUserIamModel> userList = snapshot.docs
          .map((doc) =>
              MQSMyQUserIamModel.fromJson(doc.data() as Map<String, dynamic>,doc.id))
          .toList();
      userList.sort((a, b) => DateTime.parse(
              b.mqsCreatedTimestamp?.isEmpty ?? false
                  ? DateTime.now().toIso8601String()
                  : b.mqsCreatedTimestamp ?? "")
          .compareTo(DateTime.parse(a.mqsCreatedTimestamp?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : a.mqsCreatedTimestamp ?? "")));

      return userList;
    });
  }

  Future<void> editUser(
      {required String docId, required MQSMyQUserIamModel userModel}) async {
    try {
      await user
          .doc(docId)
          .set(userModel.toJson(), SetOptions(merge: true));
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    }
  }

  Future<void> addUser(
      {required MQSMyQUserIamModel userModel,
        required String customId}) async {
    await user.doc(customId).set({
      ...userModel.toJson(),
    });
  }

  Future deleteUser({required String docId}) async {
    await user.doc(docId).delete();
  }

  Future<List<MQSMyQUserSubscriptionReceiptModel>>
      getUserSubscriptionReceipt() async {
    QuerySnapshot<Object?> receipt = await userSubscriptionReceipt.get();
    List<MQSMyQUserSubscriptionReceiptModel> receiptList = receipt.docs
        .map((e) => MQSMyQUserSubscriptionReceiptModel.fromJson(
            e.data() as Map<String, dynamic>, e.id))
        .toList();
    return receiptList;
  }

  Stream<List<MQSMyQUserSubscriptionReceiptModel>>
      getUserSubscriptionReceiptStream() {
    return userSubscriptionReceipt.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MQSMyQUserSubscriptionReceiptModel.fromJson(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<List<MQSMyQUserIamModel>> fetchUserFilteredData(
      String fieldKey,
      String field2Key,
      List<Map<String, dynamic>> filter,
      String condition,
      bool isAsc) async {
    Query query = user;
    List<MQSMyQUserIamModel> allRes = [];
    List<MQSMyQUserIamModel> matchedUsers = [];
    if (filter.isEmpty) {
      query = query.orderBy(fieldKey, descending: !isAsc);
    }
    List<MQSMyQUserIamModel> userList = await getUsers();

    for (Map<String, dynamic> filter in filter) {
      String field = filter['field'];
      var condition = filter['condition'];
      if (condition is Map<String, dynamic>) {
        String operator = condition['operator'];
        dynamic type = condition['type'];
        dynamic value = condition['value'];
        switch (operator) {
          case '==': // Equal to

            if (field2Key.isNotEmpty) {
              Query query1 = user
                  .where(fieldKey,
                      isEqualTo: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(fieldKey, descending: !isAsc);
              Query query2 = user
                  .where(field2Key,
                      isEqualTo: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(field2Key, descending: !isAsc);

              QuerySnapshot snapshot1 = await query1.get();
              QuerySnapshot snapshot2 = await query2.get();

              matchedUsers = [
                ...snapshot1.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
                ...snapshot2.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
              ];
              // }
            } else {
              if (fieldKey == "mqsCreatedTimestamp") {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  String? timeVal = e.mqsCreatedTimestamp?.isNotEmpty ?? false
                      ? e.mqsCreatedTimestamp
                      : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                          ? e.mqsEnterpriseCreatedTimestamp
                          : DateTime.now().toIso8601String();

                  return timeVal?.contains(value) ?? false;
                }).toList());
              } else {
                query = query
                    .where(field,
                        isEqualTo: type == StringConfig.dashboard.boolean
                            ? value == 'true'
                            : value.toString())
                    .orderBy(field, descending: !isAsc);
              }
            }
            break;
          case '!=': // Not equal to
            if (field2Key.isNotEmpty) {
              Query query1 = user
                  .where(fieldKey,
                      isNotEqualTo: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(fieldKey, descending: !isAsc);

              Query query2 = user
                  .where(field2Key,
                      isNotEqualTo: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(field2Key, descending: !isAsc);

              QuerySnapshot snapshot1 = await query1.get();
              QuerySnapshot snapshot2 = await query2.get();

              matchedUsers = [
                ...snapshot1.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
                ...snapshot2.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
              ];
            } else {
              if (fieldKey == "mqsCreatedTimestamp") {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  String? timeVal = e.mqsCreatedTimestamp?.isNotEmpty ?? false
                      ? e.mqsCreatedTimestamp
                      : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                          ? e.mqsEnterpriseCreatedTimestamp
                          : DateTime.now().toIso8601String();

                  return !(timeVal?.contains(value) ?? false);
                }).toList());
              } else {
                query = query
                    .where(field,
                        isNotEqualTo: type == StringConfig.dashboard.boolean
                            ? value == 'true'
                            : value.toString())
                    .orderBy(field, descending: !isAsc);
              }
            }
            break;
          case '>': // Greater than
            if (field2Key.isNotEmpty) {
              Query query1 = user
                  .where(fieldKey,
                      isGreaterThan: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(fieldKey, descending: !isAsc);

              Query query2 = user
                  .where(field2Key,
                      isGreaterThan: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(field2Key, descending: !isAsc);

              QuerySnapshot snapshot1 = await query1.get();
              QuerySnapshot snapshot2 = await query2.get();

              matchedUsers = [
                ...snapshot1.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
                ...snapshot2.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
              ];
            } else {
              query = query
                  .where(field,
                      isGreaterThan: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(field, descending: !isAsc);
            }
            break;
          case '>=': // Greater than or equal to
            if (field2Key.isNotEmpty) {
              Query query1 = user
                  .where(fieldKey,
                      isGreaterThanOrEqualTo:
                          type == StringConfig.dashboard.boolean
                              ? value == 'true'
                              : value.toString())
                  .orderBy(fieldKey, descending: !isAsc);

              Query query2 = user
                  .where(field2Key,
                      isGreaterThanOrEqualTo:
                          type == StringConfig.dashboard.boolean
                              ? value == 'true'
                              : value.toString())
                  .orderBy(field2Key, descending: !isAsc);

              QuerySnapshot snapshot1 = await query1.get();
              QuerySnapshot snapshot2 = await query2.get();

              matchedUsers = [
                ...snapshot1.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
                ...snapshot2.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
              ];
            } else {
              query = query
                  .where(field,
                      isGreaterThanOrEqualTo:
                          type == StringConfig.dashboard.boolean
                              ? value == 'true'
                              : value.toString())
                  .orderBy(field, descending: !isAsc);
            }
            break;
          case '<': // Less than
            if (field2Key.isNotEmpty) {
              Query query1 = user
                  .where(fieldKey,
                      isLessThan: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(fieldKey, descending: !isAsc);

              Query query2 = user
                  .where(field2Key,
                      isLessThan: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(field2Key, descending: !isAsc);

              QuerySnapshot snapshot1 = await query1.get();
              QuerySnapshot snapshot2 = await query2.get();

              matchedUsers = [
                ...snapshot1.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
                ...snapshot2.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
              ];
            } else {
              query = query
                  .where(field,
                      isLessThan: type == StringConfig.dashboard.boolean
                          ? value == 'true'
                          : value.toString())
                  .orderBy(field, descending: !isAsc);
            }
            break;
          case '<=': // Less than or equal to
            if (field2Key.isNotEmpty) {
              Query query1 = user
                  .where(fieldKey,
                      isLessThanOrEqualTo:
                          type == StringConfig.dashboard.boolean
                              ? value == 'true'
                              : value.toString())
                  .orderBy(fieldKey, descending: !isAsc);

              Query query2 = user
                  .where(field2Key,
                      isLessThanOrEqualTo:
                          type == StringConfig.dashboard.boolean
                              ? value == 'true'
                              : value.toString())
                  .orderBy(field2Key, descending: !isAsc);

              QuerySnapshot snapshot1 = await query1.get();
              QuerySnapshot snapshot2 = await query2.get();

              matchedUsers = [
                ...snapshot1.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
                ...snapshot2.docs.map((doc) => MQSMyQUserIamModel.fromJson(
                    doc.data() as Map<String, dynamic>,doc.id)),
              ];
            } else {
              query = query
                  .where(field,
                      isLessThanOrEqualTo:
                          type == StringConfig.dashboard.boolean
                              ? value == 'true'
                              : value.toString())
                  .orderBy(field, descending: !isAsc);
            }
            break;
          case 'array-contains-any': // Array contains any
            if (!allRes.contains(value)) {
              if (fieldKey == 'mqsEnterpriseDetails') {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  Map<String, dynamic> json =
                      e.toJson(); // Convert object to JSON
                  String? fieldValue =
                      json[field]?.toString(); // Get the dynamic field value

                  return fieldValue != null &&
                      (fieldValue.contains(value) ||
                          json["enterPriseID"] == value);
                }).toList());
              }
              // else if (fieldKey == 'mqsOnboardingDetails') {
              //   allRes.addAll(userList.where((MQSMyQUserIamModel e) {
              //     return e.mqsOnboardingDetails
              //             ?.toJson()
              //             .toString()
              //             .contains(value) ??
              //         false;
              //   }).toList());
              // }
              else if (fieldKey == 'mqsUserJMStatus') {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  return e.mqsUserJMStatus
                          ?.toJson()
                          .toString()
                          .contains(value) ??
                      false;
                }).toList());
              } else if (fieldKey == 'mqsUserChallengesStatus') {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  return e.mqsUserChallengesStatus
                          ?.toJson()
                          .toString()
                          .contains(value) ??
                      false;
                }).toList());
              } else if (fieldKey == 'mqsPrivacySettingsDetails') {

                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  return e.mqsPrivacySettingsDetails
                          ?.toJson()
                          .toString()
                          .contains(value) ??
                      false;
                }).toList());
              } else if (fieldKey == 'mqsUserGrowth') {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  return e.mqsUserGrowth
                          ?.toJson()
                          .toString()
                          .contains(value) ??
                      false;
                }).toList());
              } else if (fieldKey == 'mqsUserProfile') {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  return e.mqsUserProfile
                          ?.toJson()
                          .toString()
                          .contains(value) ??
                      false;
                }).toList());
              } else if (fieldKey == 'mqsUserMilestones') {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  return e.mqsUserMilestones?.any((e)=>e.toJson().toString().contains(value)) ??false;
                }).toList());
              }
              else if (fieldKey == 'mqsUserBadges') {
                allRes.addAll(userList.where((MQSMyQUserIamModel e) {
                  return e.mqsUserBadges?.any((e)=>e.toJson().toString().contains(value)) ??false;
                }).toList());
              }
            }
            break;
          default:
            break;
        }
      }
    }
    if (condition == "array-contains-any" ||
        (condition == "==" && fieldKey == "mqsCreatedTimestamp") ||
        (condition == "!=" && fieldKey == "mqsCreatedTimestamp")) {
      return allRes;
    } else {
      if (field2Key.isNotEmpty) {
        return matchedUsers;
      } else {
        // Get the filtered query results
        QuerySnapshot querySnapshot = await query.get();
        // Return the matching documents

        return querySnapshot.docs
            .map((e) =>
                MQSMyQUserIamModel.fromJson(e.data() as Map<String, dynamic>,e.id))
            .toList();
      }
    }
  }

  Future<void> addUserSubRec(
      {required MQSMyQUserSubscriptionReceiptModel userSubscriptionReceiptModel,
      required String customId}) async {
    await userSubscriptionReceipt.doc(customId).set({
      ...userSubscriptionReceiptModel.toJson(),
    });
  }

  Future<void> editUserSubRec(
      {required String docId,
      required MQSMyQUserSubscriptionReceiptModel
          userSubscriptionReceiptModel}) async {
    try {
      await userSubscriptionReceipt
          .doc(docId)
          .set(userSubscriptionReceiptModel.toJson(), SetOptions(merge: true));
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    }
  }

  Future deleteUserSubRec({required String docId}) async {
    await userSubscriptionReceipt.doc(docId).delete();
  }

  Future<List<MQSMyQUserSubscriptionReceiptModel>>
      fetchUserSubscriptionFilteredData(
          String fieldKey,
          List<Map<String, dynamic>> filter,
          String condition,
          bool isAsc) async {
    Query query = userSubscriptionReceipt;
    List<MQSMyQUserSubscriptionReceiptModel> allRes = [];
    if (filter.isEmpty) {
      query = query.orderBy(fieldKey, descending: !isAsc);
    }
    List<MQSMyQUserSubscriptionReceiptModel> userSubRecList =
        await getUserSubscriptionReceipt();
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
            if (!allRes.contains(value)) {
              allRes.addAll(
                  userSubRecList.where((MQSMyQUserSubscriptionReceiptModel e) {
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
      QuerySnapshot querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MQSMyQUserSubscriptionReceiptModel.fromJson(data,doc.id);
      }).toList();
    }
  }
}
