import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_pathway_model.dart';
import 'package:mqs_admin_portal_web/views/pathway/repository/pathway_repository.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

class PathwayController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxBool isAdd = false.obs,
      isEdit = false.obs,
      showModules = false.obs,
      showPathwayDep = false.obs,
      showLearnActivty = false.obs,
      showPracActivity = false.obs,
      learnActScreenHandoff = false.obs,
      pracActScreenHandoff = false.obs,
      showLearnActSkills = false.obs,
      showPracActSkills = false.obs,
      showPracActReqIcons = false.obs;
  RxList<MQSMyQPathwayModel> searchedPathway = <MQSMyQPathwayModel>[].obs,
      pathway = <MQSMyQPathwayModel>[].obs;
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  int get totalCirclePage => (searchedPathway.length / pageLimit.value).ceil();
  RxInt viewIndex = (-1).obs;
  MQSMyQPathwayModel get pathwayDetail => searchedPathway[viewIndex.value];
  List<MqsModule> get modules =>
      pathwayDetail.mqsPathwayDetail?.mqsModules ?? [];
  StreamSubscription<List>? pathwayStream;
  final GlobalKey<FormState> pathwayFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> pathwayDepFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> moduleFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> learnActFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> pracActFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> learnActSkillFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> pracActSkillFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> pracActReqIconFormKey = GlobalKey<FormState>();
  RxList<int> moduleIndexes = <int>[].obs;
  final TextEditingController idController = TextEditingController();
  final TextEditingController aboutPathwayController = TextEditingController();
  final TextEditingController learningObjController = TextEditingController();
  final TextEditingController coachInstructionsController =
      TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController pathwayDepController = TextEditingController();
  final TextEditingController moduleIdController = TextEditingController();
  final TextEditingController moduleTitleController = TextEditingController();
  final TextEditingController moduleSubtitleController =
      TextEditingController();
  final TextEditingController learnActIdController = TextEditingController();
  final TextEditingController learnActRefIdController = TextEditingController();
  final TextEditingController learnActTitleController = TextEditingController();
  final TextEditingController learnActController = TextEditingController();
  final TextEditingController learnActNavigateToScreenController =
      TextEditingController();
  final TextEditingController learnActAudioLessonController =
      TextEditingController();
  final TextEditingController learnActBenefitsController =
      TextEditingController();
  final TextEditingController learnActCoachInstructionsController =
      TextEditingController();
  final TextEditingController learnActDurationController =
      TextEditingController();
  final TextEditingController learnActLessonDetailController =
      TextEditingController();
  final TextEditingController learnActRefQueController =
      TextEditingController();
  final TextEditingController learnActVideoLessonController =
      TextEditingController();
  final TextEditingController learnActMqsInfoController =
      TextEditingController();
  final TextEditingController learnActSkillController = TextEditingController();
  final TextEditingController pracActIdController = TextEditingController();
  final TextEditingController pracActInstructionsController =
      TextEditingController();
  final TextEditingController pracActRefIdController = TextEditingController();
  final TextEditingController pracActTitleController = TextEditingController();
  final TextEditingController pracActNavigateToScreenController =
      TextEditingController();
  final TextEditingController pracActAudioLessonController =
      TextEditingController();
  final TextEditingController pracActBenefitsController =
      TextEditingController();
  final TextEditingController pracActCoachInstructionsController =
      TextEditingController();
  final TextEditingController pracActDurationController =
      TextEditingController();
  final TextEditingController pracActLessonDetailController =
      TextEditingController();
  final TextEditingController pracActRefQueController = TextEditingController();
  final TextEditingController pracActUIController = TextEditingController();
  final TextEditingController pracActVideoLessonController =
      TextEditingController();
  final TextEditingController pracActMqsInfoController =
      TextEditingController();
  final TextEditingController pracActSkillController = TextEditingController();
  final TextEditingController pracActReqIconController =
      TextEditingController();
  RxString selectedPathwayType = "".obs;
  List<String> get pathwayTypes => [
        StringConfig.pathway.fundamentals,
        StringConfig.pathway.humanQualities,
        StringConfig.pathway.situations
      ];
  RxList<String> pathwayDep = <String>[].obs,
      learnActSkills = <String>[].obs,
      pracActSkills = <String>[].obs,
      pracActReqIcons = <String>[].obs;
  Rx<Uint8List> pathwayImage = Uint8List(0).obs,
      pathwayIntroImage = Uint8List(0).obs,
      pathwayTileImage = Uint8List(0).obs,
      moduleTileImage = Uint8List(0).obs,
      learnAudio = Uint8List(0).obs,
      learnVideo = Uint8List(0).obs,
      pracAudio = Uint8List(0).obs,
      pracVideo = Uint8List(0).obs;
  RxList<MqsModule> mqsModules = <MqsModule>[].obs;
  RxList<MqsLearnActivity> mqsLearnActivity = <MqsLearnActivity>[].obs;
  RxList<MqsPracticeActivity> mqsPracticeActivity = <MqsPracticeActivity>[].obs;
  List<DropdownMenuItem> get boolOptions => [
        DropdownMenuItem(
          value: true,
          child: Text(
            StringConfig.dashboard.trueText,
            style: FontTextStyleConfig.textFieldTextStyle
                .copyWith(fontSize: FontSizeConfig.fontSize16),
          ),
        ),
        DropdownMenuItem(
          value: false,
          child: Text(
            StringConfig.dashboard.falseText,
            style: FontTextStyleConfig.textFieldTextStyle
                .copyWith(fontSize: FontSizeConfig.fontSize16),
          ),
        )
      ];

  @override
  onInit() {
    getPathway();
    super.onInit();
  }

  @override
  void onClose() async {
    await pathwayStream?.cancel();
    super.onClose();
  }

  getPathway() async {
    try {
      List<MQSMyQPathwayModel> pathwayList =
          await PathwayRepository.i.getPathways();
      searchedPathway.value = pathwayList;
      pathway.value = pathwayList;
      pathwayStream = PathwayRepository.i.getPathwayStream().listen((list) {
        searchedPathway.value = list;
        pathway.value = list;
        viewIndex.value = -1;
      });
      // Set filter fields of pathway in filter sheet
      // if (Get.isRegistered<DashboardController>()) {
      //   Get.find<DashboardController>().setFilterFields();
      // }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  addPathwayDep() {
    pathwayDep.add(pathwayDepController.text.trim());
    pathwayDepController.clear();
  }

  removePathwayDep({required int index}) {
    pathwayDep.removeAt(index);
  }

  Future<Uint8List?> pickImage() async {
    try {
      FilePickerResult? image =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (image != null) {
        return image.files.first.bytes;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
    return null;
  }

  Future<Map<String, Uint8List?>> pickAudio() async {
    try {
      FilePickerResult? audio =
          await FilePicker.platform.pickFiles(type: FileType.audio);
      if (audio != null) {
        return {audio.files.first.name: audio.files.first.bytes};
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
    return {};
  }

  Future<Map<String, Uint8List?>> pickVideo() async {
    try {
      FilePickerResult? video =
          await FilePicker.platform.pickFiles(type: FileType.video);
      if (video != null) {
        return {video.files.first.name: video.files.first.bytes};
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
    return {};
  }

  addLearnActSkill() {
    learnActSkills.add(learnActSkillController.text.trim());
    learnActSkillController.clear();
  }

  removeLearnActSkill({required int index}) {
    learnActSkills.removeAt(index);
  }

  addPracActSkill() {
    pracActSkills.add(pracActSkillController.text.trim());
    pracActSkillController.clear();
  }

  removePracActSkill({required int index}) {
    pracActSkills.removeAt(index);
  }

  addPracActReqIcon() {
    pracActReqIcons.add(pracActReqIconController.text.trim());
    pracActReqIconController.clear();
  }

  removePracActReqIcon({required int index}) {
    pracActReqIcons.removeAt(index);
  }

  addLearnActivity() {
    mqsLearnActivity.add(
      MqsLearnActivity(
        id: learnActIdController.text.trim(),
        mqsActivityRefID: learnActRefIdController.text.trim(),
        mqsModuleID: moduleIdController.text.trim(),
        mqsActivityTitle: learnActTitleController.text.trim(),
        mqsActivityScreenHandoff: learnActScreenHandoff.value,
        mqsNavigateToScreen: learnActNavigateToScreenController.text.trim(),
        mqsActivitySkill: [],
        activity: MqsLearnActivityDetail(
          mqsActivityAudioLesson: "",
          mqsActivityBenefits: learnActBenefitsController.text.trim(),
          mqsActivityCoachInstructions:
              learnActCoachInstructionsController.text.trim(),
          mqsActivityDuration: int.parse(learnActDurationController.text),
          mqsActivityLessonDetail: learnActLessonDetailController.text.trim(),
          mqsActivityReflectionQuestion: learnActRefQueController.text.trim(),
          mqsActivityVideoLesson: "",
          mqsInfo: learnActMqsInfoController.text.trim(),
        ),
      ),
    );
  }

  removeLearnActivity({required int index}) {
    mqsLearnActivity.removeAt(index);
  }

  addPracActivity() {
    mqsPracticeActivity.add(
      MqsPracticeActivity(
        id: pracActIdController.text.trim(),
        mqsActivityRefID: pracActRefIdController.text.trim(),
        mqsModuleID: moduleIdController.text.trim(),
        mqsActivityTitle: pracActTitleController.text.trim(),
        mqsActivityScreenHandoff: pracActScreenHandoff.value,
        mqsNavigateToScreen: pracActNavigateToScreenController.text.trim(),
        mqsActivitySkill: [],
        mqsActivityInstruction: pracActInstructionsController.text.trim(),
        mqsActivityReqIcons: [],
        activity: MqsPracticeActivityDetail(
          mqsActivityAudioLesson: "",
          mqsActivityBenefits: pracActBenefitsController.text.trim(),
          mqsActivityCoachInstructions:
              pracActCoachInstructionsController.text.trim(),
          mqsActivityDuration: int.parse(pracActDurationController.text),
          mqsActivityLessonDetail: pracActLessonDetailController.text.trim(),
          mqsActivityReflectionQuestion: pracActRefQueController.text.trim(),
          mqsActivityVideoLesson: "",
          mqsInfo: pracActMqsInfoController.text.trim(),
          mqsActivityUI: pracActUIController.text.trim(),
        ),
      ),
    );
  }

  removePracActivity({required int index}) {
    mqsPracticeActivity.removeAt(index);
  }

  addModule() {
    mqsModules.add(
      MqsModule(
        id: moduleIdController.text.trim(),
        moduleTitle: moduleTitleController.text.trim(),
        mqsModuleSubtitle: moduleSubtitleController.text.trim(),
        moduleTileImage: "",
        mqsLearnActivity: [
          // MqsLearnActivity(
          //   id: learnActIdController.text.trim(),
          //   mqsActivityRefID: mqsActivityRefID,
          //   mqsModuleID: mqsModuleID,
          //   mqsActivityTitle: mqsActivityTitle,
          //   mqsActivityScreenHandoff: mqsActivityScreenHandoff,
          //   mqsNavigateToScreen: mqsNavigateToScreen,
          //   mqsActivitySkill: mqsActivitySkill,
          //   activity: activity,
          // ),
        ],
        mqsPracticeActivity: [
          // MqsPracticeActivity(
          //   id: id,
          //   mqsActivityInstruction: mqsActivityInstruction,
          //   mqsActivityRefID: mqsActivityRefID,
          //   mqsActivityReqIcons: mqsActivityReqIcons,
          //   mqsActivityScreenHandoff: mqsActivityScreenHandoff,
          //   mqsActivitySkill: mqsActivitySkill,
          //   mqsActivityTitle: mqsActivityTitle,
          //   mqsModuleID: mqsModuleID,
          //   mqsNavigateToScreen: mqsNavigateToScreen,
          //   activity: activity,
          // )
        ],
      ),
    );
  }

  removeModule({required int index}) {
    try {
      mqsModules.removeAt(index);
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getMaxOffset() {
    int rem = searchedPathway.length % pageLimit.value;
    if (rem != 0 && currentPage.value == totalCirclePage) {
      return offset.value + rem;
    }
    return offset.value + pageLimit.value;
  }

  prevPage() {
    try {
      if (currentPage > 1) {
        offset.value = offset.value - pageLimit.value;
        currentPage.value--;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  nextPage() {
    try {
      if (currentPage.value < totalCirclePage) {
        offset.value = offset.value + pageLimit.value;
        currentPage.value++;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  reset() {
    viewIndex.value = -1;
    currentPage.value = 1;
    offset.value = 0;
  }

  clearAllFields() {
    idController.clear();
    titleController.clear();
    subtitleController.clear();
    selectedPathwayType.value = "";
    aboutPathwayController.clear();
    learningObjController.clear();
    coachInstructionsController.clear();
    durationController.clear();
    levelController.clear();
    pathwayImage.value = Uint8List(0);
    pathwayIntroImage.value = Uint8List(0);
    pathwayTileImage.value = Uint8List(0);
    showModules.value = false;
    pathwayDep.clear();
    clearModuleFields();
  }

  clearModuleFields() {
    moduleIdController.clear();
    moduleTitleController.clear();
    moduleSubtitleController.clear();
    moduleTileImage.value = Uint8List(0);
    clearLearnActivityFields();
    clearPracActivityFields();
  }

  clearLearnActivityFields() {
    showLearnActivty.value = false;
    learnActIdController.clear();
    learnActTitleController.clear();
    learnActNavigateToScreenController.clear();
    learnActRefIdController.clear();
    learnActAudioLessonController.clear();
    learnActBenefitsController.clear();
    learnActCoachInstructionsController.clear();
    learnActDurationController.clear();
    learnActLessonDetailController.clear();
    learnActVideoLessonController.clear();
    learnActMqsInfoController.clear();
    learnAudio.value = Uint8List(0);
    learnVideo.value = Uint8List(0);
    learnActScreenHandoff.value = false;
  }

  clearPracActivityFields() {
    showPracActivity.value = false;
    pracActIdController.clear();
    pracActCoachInstructionsController.clear();
    pracActRefIdController.clear();
    pracActTitleController.clear();
    pracActNavigateToScreenController.clear();
    pracActAudioLessonController.clear();
    pracActBenefitsController.clear();
    pracActCoachInstructionsController.clear();
    pracActDurationController.clear();
    pracActLessonDetailController.clear();
    pracActRefQueController.clear();
    pracActUIController.clear();
    pracActVideoLessonController.clear();
    pracActMqsInfoController.clear();
    pracAudio.value = Uint8List(0);
    pracVideo.value = Uint8List(0);
    pracActScreenHandoff.value = false;
  }

  addPathway() async {
    try {
      if (pathwayFormKey.currentState?.validate() ?? false) {}
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  deletePathway({required String docId}) async {
    try {
      showLoader();
      viewIndex.value = 0;
      isAdd.value = false;
      isEdit.value = false;
      hideLoader();
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  searchPathway() {
    try {
      reset();
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedPathway.value = pathway;
      } else {
        searchedPathway.value = pathway
            .where((e) =>
                e.id.toLowerCase().contains(query) ||
                e.mqsPathwayTitle.toLowerCase().contains(query) ||
                e.mqsPathwaySubtitle.toLowerCase().contains(query) ||
                e.mqsPathwayType.toLowerCase().contains(query) ||
                e.mqsAboutPathway.toLowerCase().contains(query) ||
                e.mqsLearningObj.toLowerCase().contains(query) ||
                e.mqsPathwayCoachInstructions.toLowerCase().contains(query))
            .toList();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  importPathway() async {
    try {} catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    }
  }

  exportPathway() async {
    try {} catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
