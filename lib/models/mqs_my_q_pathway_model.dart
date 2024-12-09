class MQSMyQPathwayModel {
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
  final String mqsPathwaySubtitle;
  final String mqsPathwayTileImage;
  final String mqsPathwayTitle;
  final String mqsPathwayType;

  MQSMyQPathwayModel(
      {required this.id,
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
      required this.mqsPathwayIntroImage,
      required this.mqsPathwayTileImage,
      required this.mqsPathwayDep,
      required this.mqsPathwayDetail});

  factory MQSMyQPathwayModel.fromJson(Map<String, dynamic> json) {
    return MQSMyQPathwayModel(
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
      mqsPathwayIntroImage: json['mqsPathwayIntroImage'] ?? "",
      mqsPathwayTileImage: json['mqsPathwayTileImage'] ?? "",
      mqsPathwayDep:
          (json['mqsPathwayDep'] as List).map((e) => e.toString()).toList(),
      mqsPathwayDetail: json['mqsPathwayDetail'] != null
          ? MqsPathwayDetail.fromJson(json['mqsPathwayDetail'])
          : null,
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
      'mqsPathwaySubtitle': mqsPathwaySubtitle,
      'mqsPathwayTileImage': mqsPathwayTileImage,
      'mqsPathwayTitle': mqsPathwayTitle,
      'mqsPathwayType': mqsPathwayType,
      'mqsLearningObj': mqsLearningObj,
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
  final String id;
  final String moduleTitle;
  final String mqsModuleSubtitle;
  final String moduleTileImage;
  final List<MqsLearnActivity> mqsLearnActivity;
  final List<MqsPracticeActivity> mqsPracticeActivity;

  MqsModule(
      {required this.id,
      required this.moduleTitle,
      required this.mqsModuleSubtitle,
      required this.moduleTileImage,
      required this.mqsLearnActivity,
      required this.mqsPracticeActivity});

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
    };
  }
}

class MqsLearnActivity {
  final String id;
  final String mqsActivityRefID;
  final bool mqsActivityScreenHandoff;
  final List<String> mqsActivitySkill;
  final String mqsActivityTitle;
  final String mqsModuleID;
  final String mqsNavigateToScreen;
  final MqsLearnActivityDetail? activity;

  MqsLearnActivity({
    required this.id,
    required this.mqsActivityRefID,
    required this.mqsModuleID,
    required this.mqsActivityTitle,
    required this.mqsActivityScreenHandoff,
    required this.mqsNavigateToScreen,
    required this.mqsActivitySkill,
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
    };
  }
}

class MqsLearnActivityDetail {
  final String mqsActivityAudioLesson;
  final String mqsActivityBenefits;
  final String mqsActivityCoachInstructions;
  final int mqsActivityDuration;
  final String mqsActivityLessonDetail;
  final String mqsActivityReflectionQuestion;
  final String mqsActivityVideoLesson;
  final String mqsInfo;

  MqsLearnActivityDetail(
      {required this.mqsActivityAudioLesson,
      required this.mqsActivityBenefits,
      required this.mqsActivityCoachInstructions,
      required this.mqsActivityDuration,
      required this.mqsActivityLessonDetail,
      required this.mqsActivityReflectionQuestion,
      required this.mqsActivityVideoLesson,
      required this.mqsInfo});

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
  final String id;
  final String mqsActivityInstruction;
  final String mqsActivityRefID;
  final List<String> mqsActivityReqIcons;
  final bool mqsActivityScreenHandoff;
  final List<String> mqsActivitySkill;
  final String mqsActivityTitle;
  final String mqsModuleID;
  final String mqsNavigateToScreen;
  final MqsPracticeActivityDetail? activity;

  MqsPracticeActivity(
      {required this.id,
      required this.mqsActivityInstruction,
      required this.mqsActivityRefID,
      required this.mqsActivityReqIcons,
      required this.mqsActivityScreenHandoff,
      required this.mqsActivitySkill,
      required this.mqsActivityTitle,
      required this.mqsModuleID,
      required this.mqsNavigateToScreen,
      required this.activity});

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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mqsActivityInstruction': mqsActivityInstruction,
      'mqsActivityRefID': mqsActivityRefID,
      // 'mqsActivityReqIcons': mqsActivityReqIcons,
      'mqsActivityScreenHandoff': mqsActivityScreenHandoff,
      // 'mqsActivitySkill': mqsActivitySkill,
      'mqsActivityTitle': mqsActivityTitle,
      'mqsModuleID': mqsModuleID,
      'mqsNavigateToScreen': mqsNavigateToScreen,
      'Activity': activity?.toJson(),
    };
  }
}

class MqsPracticeActivityDetail {
  final String mqsActivityAudioLesson;
  final String mqsActivityBenefits;
  final String mqsActivityCoachInstructions;
  final int mqsActivityDuration;
  final String mqsActivityLessonDetail;
  final String mqsActivityReflectionQuestion;
  final String mqsActivityUI;
  final String mqsActivityVideoLesson;
  final String mqsInfo;

  MqsPracticeActivityDetail(
      {required this.mqsActivityAudioLesson,
      required this.mqsActivityBenefits,
      required this.mqsActivityCoachInstructions,
      required this.mqsActivityDuration,
      required this.mqsActivityLessonDetail,
      required this.mqsActivityReflectionQuestion,
      required this.mqsActivityUI,
      required this.mqsActivityVideoLesson,
      required this.mqsInfo});

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
