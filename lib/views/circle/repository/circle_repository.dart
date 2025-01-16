import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class CircleRepository {
  CircleRepository._();
  static final i = CircleRepository._();
  CollectionReference get circle => FirebaseStorageService.i.circle;

  Future<List<CircleModel>> getCircles() async {
    QuerySnapshot<Object?> cir = await circle.get();
    List<CircleModel> cirList = cir.docs.map((e) {
      CircleModel model =
          CircleModel.fromJson(e.data() as Map<String, dynamic>);
      model.id = e.id;
      return model;
    }).toList();
    cirList.sort((a, b) => DateTime.parse(
            b.postTime ?? DateTime.now().toIso8601String())
        .compareTo(
            DateTime.parse(a.postTime ?? DateTime.now().toIso8601String())));
    return cirList;
  }

  Stream<List<CircleModel>> getCircleStream() {
    return circle.snapshots().map((snapshot) {
      List<CircleModel> cirList = snapshot.docs.map((doc) {
        CircleModel model =
            CircleModel.fromJson(doc.data() as Map<String, dynamic>);
        model.id = doc.id;
        return model;
      }).toList();
      cirList.sort((a, b) => DateTime.parse(
              b.postTime ?? DateTime.now().toIso8601String())
          .compareTo(
              DateTime.parse(a.postTime ?? DateTime.now().toIso8601String())));
      return cirList;
    });
  }

  Future<void> editCircle(
      {required String docId, required CircleModel circleModel}) async {
    try {
      await circle
          .doc(docId)
          .set(circleModel.toJson(), SetOptions(merge: true));
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    }
  }

  Future<void> addCircle(
      {required CircleModel circleModel, required String customId}) async {
    await circle.doc(customId).set({
      ...circleModel.toJson(),
    });
  }

  Future deleteCircle({required String docId}) async {
    await circle.doc(docId).delete();
  }

  Future<List<CircleModel>> fetchCircleFilteredData(String fieldKey,
      List<Map<String, dynamic>> filter, String condition, bool isAsc) async {
    Query query = circle;
    List<CircleModel> allRes = [];
    if (filter.isEmpty) {
      query = query.orderBy(fieldKey, descending: !isAsc);
    }
    List<CircleModel> circleList = await getCircles();
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
                        : field == 'post_view'
                            ? int.parse(value)
                            : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '!=': // Not equal to
            query = query
                .where(field,
                    isNotEqualTo: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : field == 'post_view'
                            ? int.parse(value)
                            : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '>': // Greater than
            query = query
                .where(field,
                    isGreaterThan: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : field == 'post_view'
                            ? int.parse(value)
                            : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '>=': // Greater than or equal to
            query = query
                .where(field,
                    isGreaterThanOrEqualTo:
                        type == StringConfig.dashboard.boolean
                            ? value == 'true'
                            : field == 'post_view'
                                ? int.parse(value)
                                : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '<': // Less than
            query = query
                .where(field,
                    isLessThan: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : field == 'post_view'
                            ? int.parse(value)
                            : value.toString())
                .orderBy(field, descending: !isAsc);
            break;
          case '<=': // Less than or equal to
            query = query
                .where(field,
                    isLessThanOrEqualTo: type == StringConfig.dashboard.boolean
                        ? value == 'true'
                        : field == 'post_view'
                            ? int.parse(value)
                            : value.toString())
                .orderBy(field, descending: !isAsc);
            break;

          case 'array-contains-any': // Array contains any
            if (!allRes.contains(value)) {
              allRes.addAll(circleList.where((CircleModel e) {
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
        return CircleModel.fromJson(data);
      }).toList();
    }
  }
}
