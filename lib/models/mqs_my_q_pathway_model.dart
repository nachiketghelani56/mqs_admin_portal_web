import 'dart:typed_data';

class MQSMyQPathwayModel {
  final String docId;
  final String id;
  final String mqsAboutPathway;
  final String mqsLearningObj;
  final int mqsModuleCount;
  final String mqsPathwayCoachInstructions;
  final List<String> mqsPathwayDep;
  final MqsPathwayDetail? mqsPathwayDetail;
  final String mqsPathwayDuration;
  final String mqsPathwayImage;
  final String mqsPathwayIntroImage;
  final int mqsPathwayLevel;
  final bool mqsPathwayStatus;
  final String mqsPathwaySubtitle;
  final String mqsPathwayTileImage;
  final String mqsPathwayTitle;
  final String mqsPathwayType;
  final String mqsPathwayCompletionDate;
  final String mqsPathwayID;
  final String mqsUserID;

  MQSMyQPathwayModel({
    required this.docId,
    required this.id,
    required this.mqsPathwayTitle,
    required this.mqsPathwaySubtitle,
    required this.mqsPathwayType,
    required this.mqsAboutPathway,
    required this.mqsLearningObj,
    required this.mqsPathwayCoachInstructions,
    required this.mqsPathwayImage,
    required this.mqsModuleCount,
    required this.mqsPathwayDuration,
    required this.mqsPathwayLevel,
    required this.mqsPathwayStatus,
    required this.mqsPathwayIntroImage,
    required this.mqsPathwayTileImage,
    required this.mqsPathwayDep,
    required this.mqsPathwayDetail,
    required this.mqsPathwayCompletionDate,
    required this.mqsPathwayID,
    required this.mqsUserID,
  });

  factory MQSMyQPathwayModel.fromJson(Map<String, dynamic> json) {
    return MQSMyQPathwayModel(
      docId: json['docId'] ?? "",
      id: json['_id'] ?? "",
      mqsPathwayTitle: json['mqsPathwayTitle'] ?? "",
      mqsPathwaySubtitle: json['mqsPathwaySubtitle'] ?? "",
      mqsPathwayType: json['mqsPathwayType'] ?? "",
      mqsAboutPathway: json['mqsAboutPathway'] ?? "",
      mqsLearningObj: json['mqsLearningObj'] ?? "",
      mqsPathwayCoachInstructions: json['mqsPathwayCoachInstructions'] ?? "",
      mqsPathwayImage: json['mqsPathwayImage'] ?? "",
      mqsModuleCount: json['mqsModuleCount'] ?? 0,
      mqsPathwayDuration: json['mqsPathwayDuration'] ?? "",
      mqsPathwayLevel: json['mqsPathwayLevel'] ?? 0,
      mqsPathwayStatus: json['mqsPathwayStatus'] ?? false,
      mqsPathwayIntroImage: json['mqsPathwayIntroImage'] ?? "",
      mqsPathwayTileImage: json['mqsPathwayTileImage'] ?? "",
      mqsPathwayDep:
          (json['mqsPathwayDep'] as List).map((e) => e.toString()).toList(),
      mqsPathwayDetail: json['mqsPathwayDetail'] != null
          ? MqsPathwayDetail.fromJson(json['mqsPathwayDetail'])
          : null,
      mqsPathwayCompletionDate: json['mqsPathwayCompletionDate'] ?? "",
      mqsPathwayID: json['mqsPathwayID'] ?? "",
      mqsUserID: json['mqsUserID'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mqsAboutPathway': mqsAboutPathway,
      'mqsModuleCount': mqsModuleCount,
      'mqsPathwayCoachInstructions': mqsPathwayCoachInstructions,
      'mqsPathwayDep': mqsPathwayDep,
      'mqsPathwayDetail': mqsPathwayDetail?.toJson(),
      'mqsPathwayDuration': mqsPathwayDuration,
      'mqsPathwayImage': mqsPathwayImage,
      'mqsPathwayIntroImage': mqsPathwayIntroImage,
      'mqsPathwayLevel': mqsPathwayLevel,
      'mqsPathwayStatus': mqsPathwayStatus,
      'mqsPathwaySubtitle': mqsPathwaySubtitle,
      'mqsPathwayTileImage': mqsPathwayTileImage,
      'mqsPathwayTitle': mqsPathwayTitle,
      'mqsPathwayType': mqsPathwayType,
      'mqsLearningObj': mqsLearningObj,
      'mqsPathwayCompletionDate': mqsPathwayCompletionDate,
      'mqsPathwayID': mqsPathwayID,
      'mqsUserID': mqsUserID,
    };
  }
}

class MqsPathwayDetail {
  final List<MqsModule> mqsModules;

  MqsPathwayDetail({required this.mqsModules});

  factory MqsPathwayDetail.fromJson(Map<String, dynamic> json) {
    return MqsPathwayDetail(
      mqsModules: json['mqsModules'] != null
          ? (json['mqsModules'] as List)
              .map((employee) => MqsModule.fromJson(employee))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsModules': mqsModules.map((module) => module.toJson()).toList(),
    };
  }
}

class MqsModule {
  String id;
  String moduleTitle;
  String mqsModuleSubtitle;
  String moduleTileImage;
  List<MqsLearnActivity> mqsLearnActivity;
  List<MqsPracticeActivity> mqsPracticeActivity;
  String mqsModuleCompletionDate;
  bool mqsPWModuleStatus;
  Uint8List? image;

  MqsModule({
    required this.id,
    required this.moduleTitle,
    required this.mqsModuleSubtitle,
    required this.moduleTileImage,
    required this.mqsLearnActivity,
    required this.mqsPracticeActivity,
    required this.mqsModuleCompletionDate,
    required this.mqsPWModuleStatus,
    this.image,
  });

  factory MqsModule.fromJson(Map<String, dynamic> json) {
    return MqsModule(
      id: json['_id'] ?? "",
      moduleTileImage: json['moduleTileImage'],
      moduleTitle: json['moduleTitle'],
      mqsLearnActivity: json['mqsLearnActivity'] != null
          ? (json['mqsLearnActivity'] as List)
              .map((e) => MqsLearnActivity.fromJson(e))
              .toList()
          : [],
      mqsModuleSubtitle: json['mqsModuleSubtitle'],
      mqsPracticeActivity: json['mqsPracticeActivity'] != null
          ? (json['mqsPracticeActivity'] as List)
              .map((e) => MqsPracticeActivity.fromJson(e))
              .toList()
          : [],
      mqsModuleCompletionDate: json['mqsModuleCompletionDate'] ?? "",
      mqsPWModuleStatus: json['mqsPWModuleStatus'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'moduleTileImage': moduleTileImage,
      'moduleTitle': moduleTitle,
      'mqsLearnActivity':
          mqsLearnActivity.map((module) => module.toJson()).toList(),
      'mqsModuleSubtitle': mqsModuleSubtitle,
      'mqsPracticeActivity':
          mqsPracticeActivity.map((module) => module.toJson()).toList(),
      'mqsModuleCompletionDate': mqsModuleCompletionDate,
      'mqsPWModuleStatus': mqsPWModuleStatus,
    };
  }
}

class MqsLearnActivity {
  String id;
  String mqsActivityRefID;
  bool mqsActivityScreenHandoff;
  List<String> mqsActivitySkill;
  String mqsActivityTitle;
  String mqsModuleID;
  String mqsNavigateToScreen;
  bool mqsActivityStatus;
  String mqsActivityCompletionDate;
  bool addToFav;
  MqsLearnActivityDetail? activity;

  MqsLearnActivity({
    required this.id,
    required this.mqsActivityRefID,
    required this.mqsModuleID,
    required this.mqsActivityTitle,
    required this.mqsActivityScreenHandoff,
    required this.mqsNavigateToScreen,
    required this.mqsActivitySkill,
    required this.mqsActivityStatus,
    required this.addToFav,
    required this.mqsActivityCompletionDate,
    required this.activity,
  });

  factory MqsLearnActivity.fromJson(Map<String, dynamic> json) {
    return MqsLearnActivity(
      id: json['_id'] ?? "",
      mqsActivityRefID: json['mqsActivityRefID'] ?? "",
      mqsActivityScreenHandoff: json['mqsActivityScreenHandoff'] ?? false,
      mqsActivitySkill:
          (json['mqsActivitySkill'] as List).map((e) => e.toString()).toList(),
      mqsModuleID: json['mqsModuleID'] ?? "",
      mqsNavigateToScreen: json['mqsNavigateToScreen'] ?? "",
      activity: json['Activity'] != null
          ? MqsLearnActivityDetail.fromJson(json['Activity'])
          : null,
      mqsActivityTitle: json['mqsActivityTitle'] ?? "",
      mqsActivityStatus: json['mqsActivityStatus'] ?? false,
      addToFav: json['addToFav'] ?? false,
      mqsActivityCompletionDate: json['mqsActivityCompletionDate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mqsActivityRefID': mqsActivityRefID,
      'mqsActivityScreenHandoff': mqsActivityScreenHandoff,
      'mqsActivitySkill': mqsActivitySkill,
      'mqsActivityTitle': mqsActivityTitle,
      'mqsModuleID': mqsModuleID,
      'mqsNavigateToScreen': mqsNavigateToScreen,
      'Activity': activity?.toJson(),
      'mqsActivityStatus': mqsActivityStatus,
      'addToFav': addToFav,
      'mqsActivityCompletionDate': mqsActivityCompletionDate,
    };
  }
}

class MqsLearnActivityDetail {
  String mqsActivityAudioLesson;
  String mqsActivityBenefits;
  String mqsActivityCoachInstructions;
  int mqsActivityDuration;
  String mqsActivityLessonDetail;
  String mqsActivityReflectionQuestion;
  String mqsActivityVideoLesson;
  String mqsInfo;
  Uint8List? audio;
  Uint8List? video;

  MqsLearnActivityDetail({
    required this.mqsActivityAudioLesson,
    required this.mqsActivityBenefits,
    required this.mqsActivityCoachInstructions,
    required this.mqsActivityDuration,
    required this.mqsActivityLessonDetail,
    required this.mqsActivityReflectionQuestion,
    required this.mqsActivityVideoLesson,
    required this.mqsInfo,
    this.audio,
    this.video,
  });

  factory MqsLearnActivityDetail.fromJson(Map<String, dynamic> json) {
    return MqsLearnActivityDetail(
      mqsActivityAudioLesson: json['mqsActivityAudioLesson'] ?? "",
      mqsActivityBenefits: json['mqsActivityBenefits'] ?? "",
      mqsActivityCoachInstructions: json['mqsActivityCoachInstructions'] ?? "",
      mqsActivityDuration: json['mqsActivityDuration'] ?? 0,
      mqsActivityLessonDetail: json['mqsActivityLessonDetail'] ?? "",
      mqsActivityReflectionQuestion:
          json['mqsActivityReflectionQuestion'] ?? "",
      mqsActivityVideoLesson: json['mqsActivityVideoLesson'] ?? "",
      mqsInfo: json['mqsInfo'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsActivityAudioLesson': mqsActivityAudioLesson,
      'mqsActivityBenefits': mqsActivityBenefits,
      'mqsActivityCoachInstructions': mqsActivityCoachInstructions,
      'mqsActivityDuration': mqsActivityDuration,
      'mqsActivityLessonDetail': mqsActivityLessonDetail,
      'mqsActivityReflectionQuestion': mqsActivityReflectionQuestion,
      'mqsActivityVideoLesson': mqsActivityVideoLesson,
      'mqsInfo': mqsInfo,
    };
  }
}

class MqsPracticeActivity {
  String id;
  String mqsActivityInstruction;
  String mqsActivityRefID;
  List<String> mqsActivityReqIcons;
  bool mqsActivityScreenHandoff;
  List<String> mqsActivitySkill;
  String mqsActivityTitle;
  String mqsModuleID;
  String mqsNavigateToScreen;
  bool mqsActivityStatus;
  String mqsActivityCompletionDate;
  bool addToFav;
  MqsPracticeActivityDetail? activity;

  MqsPracticeActivity({
    required this.id,
    required this.mqsActivityInstruction,
    required this.mqsActivityRefID,
    required this.mqsActivityReqIcons,
    required this.mqsActivityScreenHandoff,
    required this.mqsActivitySkill,
    required this.mqsActivityTitle,
    required this.mqsModuleID,
    required this.mqsNavigateToScreen,
    required this.activity,
    required this.addToFav,
    required this.mqsActivityCompletionDate,
    required this.mqsActivityStatus,
  });

  factory MqsPracticeActivity.fromJson(Map<String, dynamic> json) {
    return MqsPracticeActivity(
      id: json['_id'] ?? "",
      mqsActivityInstruction: json['mqsActivityInstruction'] ?? "",
      mqsActivityRefID: json['mqsActivityRefID'] ?? "",
      mqsActivityReqIcons: (json['mqsActivityReqIcons'] as List)
          .map((e) => e.toString())
          .toList(),
      mqsActivityScreenHandoff: json['mqsActivityScreenHandoff'] ?? false,
      mqsActivitySkill:
          (json['mqsActivitySkill'] as List).map((e) => e.toString()).toList(),
      mqsActivityTitle: json['mqsActivityTitle'] ?? "",
      mqsModuleID: json['mqsModuleID'] ?? "",
      mqsNavigateToScreen: json['mqsNavigateToScreen'] ?? "",
      activity: json['Activity'] != null
          ? MqsPracticeActivityDetail.fromJson(json['Activity'])
          : null,
      addToFav: json['addToFav'] ?? false,
      mqsActivityCompletionDate: json['mqsActivityCompletionDate'] ?? "",
      mqsActivityStatus: json['mqsActivityStatus'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mqsActivityInstruction': mqsActivityInstruction,
      'mqsActivityRefID': mqsActivityRefID,
      'mqsActivityReqIcons': mqsActivityReqIcons,
      'mqsActivityScreenHandoff': mqsActivityScreenHandoff,
      'mqsActivitySkill': mqsActivitySkill,
      'mqsActivityTitle': mqsActivityTitle,
      'mqsModuleID': mqsModuleID,
      'mqsNavigateToScreen': mqsNavigateToScreen,
      'Activity': activity?.toJson(),
      'addToFav': addToFav,
      'mqsActivityCompletionDate': mqsActivityCompletionDate,
      'mqsActivityStatus': mqsActivityStatus,
    };
  }
}

class MqsPracticeActivityDetail {
  String mqsActivityAudioLesson;
  String mqsActivityBenefits;
  String mqsActivityCoachInstructions;
  int mqsActivityDuration;
  String mqsActivityLessonDetail;
  String mqsActivityReflectionQuestion;
  String mqsActivityUI;
  String mqsActivityVideoLesson;
  String mqsInfo;
  Uint8List? audio;
  Uint8List? video;

  MqsPracticeActivityDetail({
    required this.mqsActivityAudioLesson,
    required this.mqsActivityBenefits,
    required this.mqsActivityCoachInstructions,
    required this.mqsActivityDuration,
    required this.mqsActivityLessonDetail,
    required this.mqsActivityReflectionQuestion,
    required this.mqsActivityUI,
    required this.mqsActivityVideoLesson,
    required this.mqsInfo,
    this.audio,
    this.video,
  });

  factory MqsPracticeActivityDetail.fromJson(Map<String, dynamic> json) {
    return MqsPracticeActivityDetail(
      mqsActivityAudioLesson: json['mqsActivityAudioLesson'] ?? "",
      mqsActivityBenefits: json['mqsActivityBenefits'] ?? "",
      mqsActivityCoachInstructions: json['mqsActivityCoachInstructions'] ?? "",
      mqsActivityDuration: json['mqsActivityDuration'] ?? 0,
      mqsActivityLessonDetail: json['mqsActivityLessonDetail'] ?? "",
      mqsActivityReflectionQuestion:
          json['mqsActivityReflectionQuestion'] ?? "",
      mqsActivityUI: json['mqsActivityUI'] ?? "",
      mqsActivityVideoLesson: json['mqsActivityVideoLesson'] ?? "",
      mqsInfo: json['mqsInfo'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsActivityAudioLesson': mqsActivityAudioLesson,
      'mqsActivityBenefits': mqsActivityBenefits,
      'mqsActivityCoachInstructions': mqsActivityCoachInstructions,
      'mqsActivityDuration': mqsActivityDuration,
      'mqsActivityLessonDetail': mqsActivityLessonDetail,
      'mqsActivityUI': mqsActivityUI,
      'mqsActivityVideoLesson': mqsActivityVideoLesson,
      'mqsInfo': mqsInfo,
    };
  }
}
