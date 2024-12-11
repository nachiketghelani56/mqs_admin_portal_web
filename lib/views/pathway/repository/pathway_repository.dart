import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_pathway_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class PathwayRepository {
  PathwayRepository._();
  static final i = PathwayRepository._();
  CollectionReference get pathway => FirebaseStorageService.i.pathway;

  Future<List<MQSMyQPathwayModel>> getPathways() async {
    QuerySnapshot<Object?> list = await pathway.get();
    List<MQSMyQPathwayModel> pathwayList = list.docs
        .map((e) => MQSMyQPathwayModel.fromJson(
            (e.data() as Map<String, dynamic>)
              ..addEntries([MapEntry("docId", e.id)])))
        .toList();
    return pathwayList;
  }

  Stream<List<MQSMyQPathwayModel>> getPathwayStream() {
    return pathway.snapshots().map((snapshot) {
      List<MQSMyQPathwayModel> list = snapshot.docs.map((doc) {
        MQSMyQPathwayModel model = MQSMyQPathwayModel.fromJson(
            (doc.data() as Map<String, dynamic>)
              ..addEntries([MapEntry("docId", doc.id)]));
        return model;
      }).toList();
      return list;
    });
  }

  Future<void> editPathway(
      {required String docId, required MQSMyQPathwayModel pathwayModel}) async {
    try {
      await pathway
          .doc(docId)
          .set(pathwayModel.toJson(), SetOptions(merge: true));
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    }
  }

  Future<void> addPathway(
      {required MQSMyQPathwayModel pathwayModel,
      required String customId}) async {
    await pathway.doc(customId).set({
      ...pathwayModel.toJson(),
    });
  }

  Future deletePathway({required String docId}) async {
    await pathway.doc(docId).delete();
  }

  Future<List<MQSMyQPathwayModel>> fetchPathwayFilteredData(String fieldKey,
      List<Map<String, dynamic>> filter, String condition, bool isAsc) async {
    Query query = pathway;
    List<MQSMyQPathwayModel> allRes = [];
    if (filter.isEmpty) {
      query = query.orderBy(fieldKey, descending: !isAsc);
    }
    List<MQSMyQPathwayModel> circleList = await getPathways();
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
              allRes.addAll(circleList.where((MQSMyQPathwayModel e) {
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
        return MQSMyQPathwayModel.fromJson(data);
      }).toList();
    }
  }
}
