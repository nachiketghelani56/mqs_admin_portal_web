import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class EnterpriseRepository {
  EnterpriseRepository._();
  static final i = EnterpriseRepository._();
  CollectionReference get enterprise => FirebaseStorageService.i.enterprise;

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
      {required String docId, required EnterpriseModel enterpriseModel}) async {
    try {
      await enterprise
          .doc(docId)
          .set(enterpriseModel.toJson(), SetOptions(merge: true));
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    }
  }

  Future<void> addEnterprises(
      {required EnterpriseModel enterpriseModel,
      required String customId}) async {
    await enterprise.doc(customId).set({
      ...enterpriseModel.toJson(),
    });
  }

  Future deleteEnterprises({required String docId}) async {
    await enterprise.doc(docId).delete();
  }

  Future<List<EnterpriseModel>> fetchEnterpriseFilteredData(String fieldKey,
      List<Map<String, dynamic>> filter, String condition, bool isAsc) async {
    Query query = enterprise;
    List<EnterpriseModel> allRes = [];
    if (filter.isEmpty) {
      query = query.orderBy(fieldKey, descending: !isAsc);
    }
    List<EnterpriseModel> enterpriseList = await getEnterprises();
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
              allRes.addAll(enterpriseList.where((EnterpriseModel e) {
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
        return EnterpriseModel.fromJson(data);
      }).toList();
    }
  }
}
