import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mqs_admin_portal_web/models/mqs_circle_flagged_post_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_team_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';

class DatabaseRepository {
  DatabaseRepository._();

  static final i = DatabaseRepository._();

  CollectionReference get team => FirebaseStorageService.i.team;
  CollectionReference get circleFlaggedPost =>
      FirebaseStorageService.i.circleFlaggedPost;

  Future<List<MqsTeamModel>> getTeams() async {
    QuerySnapshot<Object?> list = await team.get();
    List<MqsTeamModel> teamList = list.docs
        .map((e) => MqsTeamModel.fromJson((e.data() as Map<String, dynamic>)
          ..addEntries([MapEntry("docId", e.id)])))
        .toList();
    return teamList;
  }

  Stream<List<MqsTeamModel>> getTeamStream() {
    return team.snapshots().map((snapshot) {
      List<MqsTeamModel> list = snapshot.docs.map((doc) {
        MqsTeamModel model = MqsTeamModel.fromJson(
            (doc.data() as Map<String, dynamic>)
              ..addEntries([MapEntry("docId", doc.id)]));
        return model;
      }).toList();
      return list;
    });
  }

  Future<List<MqsCircleFlaggedPostModel>> getCircleFlaggedPost() async {
    QuerySnapshot<Object?> list = await circleFlaggedPost.get();

    List<MqsCircleFlaggedPostModel> circleFlaggedPostList = list.docs
        .map((e) => MqsCircleFlaggedPostModel.fromJson(
            (e.data() as Map<String, dynamic>)))
        .toList();

    return circleFlaggedPostList;
  }

  Stream<List<MqsCircleFlaggedPostModel>> getCircleFlaggedPostStream() {
    return circleFlaggedPost.snapshots().map((snapshot) {
      List<MqsCircleFlaggedPostModel> list = snapshot.docs.map((doc) {
        MqsCircleFlaggedPostModel model = MqsCircleFlaggedPostModel.fromJson(
            (doc.data() as Map<String, dynamic>));
        return model;
      }).toList();
      return list;
    });
  }
}
