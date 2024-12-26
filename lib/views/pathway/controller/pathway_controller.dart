import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/menu_option_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_pathway_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_model_export_service.dart';
import 'package:mqs_admin_portal_web/services/firebase_model_import_service.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_repository.dart';
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
  RxInt pageLimit = 10.obs,
      offset = 0.obs,
      currentPage = 1.obs,
      viewIndex = (-1).obs,
      editLearnActIndex = (-1).obs,
      editPracActIndex = (-1).obs,
      editModuleIndex = (-1).obs;
  int get totalCirclePage => (searchedPathway.length / pageLimit.value).ceil();
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
  RxInt moduleIndex = (-1).obs,
      learnActIndex = (-1).obs,
      pracActIndex = (-1).obs;
  final TextEditingController idController = TextEditingController();
  final TextEditingController aboutPathwayController = TextEditingController();
  final TextEditingController learningObjController = TextEditingController();
  final TextEditingController coachInstructionsController =
      TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController pathwayCompletionDateController =
      TextEditingController();
  final TextEditingController pathwayDepController = TextEditingController();
  final TextEditingController moduleIdController = TextEditingController();
  final TextEditingController moduleTitleController = TextEditingController();
  final TextEditingController moduleSubtitleController =
      TextEditingController();
  final TextEditingController moduleCompletionDateController =
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
  final TextEditingController learnActCompletionDateController =
      TextEditingController();
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
  final TextEditingController pracActCompletionDateController =
      TextEditingController();
  RxString selectedPathwayType = "".obs, selectedUserID = "".obs;
  RxBool pathwayStatus = false.obs,
      moduleStatus = false.obs,
      learnActStatus = false.obs,
      learnActAddToFav = false.obs,
      pracActStatus = false.obs,
      pracActAddToFav = false.obs;
  List<String> get pathwayTypes => [
        StringConfig.pathway.fundamentals,
        StringConfig.pathway.humanQualities,
        StringConfig.pathway.situations
      ];
  RxList<UserIAMModel> users = <UserIAMModel>[].obs;
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
  RxString pathwayImageURL = "".obs,
      pathwayIntroImageURL = "".obs,
      pathwayTileImageURL = "".obs,
      moduleTileImageURL = "".obs;
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
  RxList<MenuOptionModel> options = [
    MenuOptionModel(
      icon: ImageConfig.edit,
      title: StringConfig.dashboard.edit,
    ),
    MenuOptionModel(
      icon: ImageConfig.delete,
      title: StringConfig.dashboard.delete,
      color: ColorConfig.deleteColor,
    ),
  ].obs;
  RxBool pathwayLoader = false.obs;
  StreamSubscription<List<UserIAMModel>>? userStream;

  final AudioPlayer audioPlayer = AudioPlayer();
  RxString currentUrl = ''.obs;
  RxDouble currentPosition = 0.0.obs;
  RxDouble totalDuration = 0.0.obs;

  @override
  onInit() {
    getPathway();
    getUsers();
    audioPlayer.positionStream.listen((position) {
      currentPosition.value = position.inMilliseconds.toDouble();
    });
    audioPlayer.durationStream.listen((duration) {
      totalDuration.value = duration?.inMilliseconds.toDouble() ?? 0.0;
    });
    // Ensure audio source initialization
    audioPlayer.setUrl('').catchError((e) {
      if (kDebugMode) {
        print('Error initializing AudioPlayer: $e');
      }
    });
    super.onInit();
  }

  void stopAudio() async {
    if (audioPlayer.playing) {
      await audioPlayer.stop();
      currentUrl.value = '';
    }
  }

  void playNewAudio(String url) async {
    if (currentUrl.value == url && audioPlayer.playing) {
      await audioPlayer.pause();
      return;
    }

    if (currentUrl.value != url) {
      await audioPlayer.stop(); // Stop current audio
      currentUrl.value = url; // Set new URL
      await audioPlayer.setUrl(url); // Load new audio
    }

    await audioPlayer.play(); // Start playback
  }

  void seekTo(double value) {
    final position = Duration(milliseconds: value.toInt());
    audioPlayer.seek(position);
  }

  @override
  void onClose() async {
    await pathwayStream?.cancel();
    await userStream?.cancel();
    super.onClose();

    audioPlayer.dispose();
  }

  getPathway() async {
    try {
      pathwayLoader.value = true;
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
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().setFilterFields();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      pathwayLoader.value = false;
    }
  }

  getUsers() async {
    try {
      users.value = await UserRepository.i.getUsers();
      userStream = UserRepository.i.getUserStream().listen((data) {
        users.value = data;
      });
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

  Future<DateTime?> pickDate({required BuildContext context}) async {
    try {
      return await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendar,
        context: context,
        firstDate: DateTime(0),
        lastDate: DateTime(3000),
        initialDate: DateTime.now(),
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
    return null;
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
        mqsActivitySkill: learnActSkills,
        mqsActivityStatus: learnActStatus.value,
        addToFav: learnActAddToFav.value,
        mqsActivityCompletionDate: learnActCompletionDateController.text,
        activity: MqsLearnActivityDetail(
          mqsActivityAudioLesson: learnActAudioLessonController.text.trim(),
          mqsActivityBenefits: learnActBenefitsController.text.trim(),
          mqsActivityCoachInstructions:
              learnActCoachInstructionsController.text.trim(),
          mqsActivityDuration: int.parse(learnActDurationController.text),
          mqsActivityLessonDetail: learnActLessonDetailController.text.trim(),
          mqsActivityReflectionQuestion: learnActRefQueController.text.trim(),
          mqsActivityVideoLesson: learnActVideoLessonController.text.trim(),
          mqsInfo: learnActMqsInfoController.text.trim(),
          audio: learnAudio.value.isNotEmpty ? learnAudio.value : null,
          video: learnVideo.value.isNotEmpty ? learnVideo.value : null,
        ),
      ),
    );
  }

  setLearnActivtyForm({required int index}) {
    editLearnActIndex.value = index;
    learnActIdController.text = mqsLearnActivity[index].id;
    learnActRefIdController.text = mqsLearnActivity[index].mqsActivityRefID;
    learnActTitleController.text = mqsLearnActivity[index].mqsActivityTitle;
    learnActScreenHandoff.value =
        mqsLearnActivity[index].mqsActivityScreenHandoff;
    learnActNavigateToScreenController.text =
        mqsLearnActivity[index].mqsNavigateToScreen;
    learnActAddToFav.value = mqsLearnActivity[index].addToFav;
    learnActStatus.value = mqsLearnActivity[index].mqsActivityStatus;
    learnActCompletionDateController.text =
        mqsLearnActivity[index].mqsActivityCompletionDate;
    learnActSkills.value =
        List<String>.from(mqsLearnActivity[index].mqsActivitySkill);
    learnActAudioLessonController.text =
        mqsLearnActivity[index].activity?.mqsActivityAudioLesson ?? "";
    learnActBenefitsController.text =
        mqsLearnActivity[index].activity?.mqsActivityBenefits ?? "";
    learnActCoachInstructionsController.text =
        mqsLearnActivity[index].activity?.mqsActivityCoachInstructions ?? "";
    learnActDurationController.text =
        "${mqsLearnActivity[index].activity?.mqsActivityDuration}";
    learnActLessonDetailController.text =
        mqsLearnActivity[index].activity?.mqsActivityLessonDetail ?? "";
    learnActRefQueController.text =
        mqsLearnActivity[index].activity?.mqsActivityReflectionQuestion ?? "";
    learnActVideoLessonController.text =
        mqsLearnActivity[index].activity?.mqsActivityVideoLesson ?? "";
    learnActMqsInfoController.text =
        mqsLearnActivity[index].activity?.mqsInfo ?? "";
    showLearnActivty.value = true;
  }

  editLearnActivity() {
    int i = editLearnActIndex.value;
    mqsLearnActivity[i].id = learnActIdController.text.trim();
    mqsLearnActivity[i].mqsActivityRefID = learnActRefIdController.text.trim();
    mqsLearnActivity[i].mqsActivityTitle = learnActTitleController.text.trim();
    mqsLearnActivity[i].mqsActivityScreenHandoff = learnActScreenHandoff.value;
    mqsLearnActivity[i].mqsNavigateToScreen =
        learnActNavigateToScreenController.text.trim();
    mqsLearnActivity[i].addToFav = learnActAddToFav.value;
    mqsLearnActivity[i].mqsActivityCompletionDate =
        learnActCompletionDateController.text;
    mqsLearnActivity[i].mqsActivityStatus = learnActStatus.value;
    mqsLearnActivity[i].mqsActivitySkill = learnActSkills;
    mqsLearnActivity[i].activity?.mqsActivityAudioLesson =
        learnActAudioLessonController.text.trim();
    mqsLearnActivity[i].activity?.mqsActivityBenefits =
        learnActBenefitsController.text.trim();
    mqsLearnActivity[i].activity?.mqsActivityCoachInstructions =
        learnActCoachInstructionsController.text.trim();
    mqsLearnActivity[i].activity?.mqsActivityDuration =
        int.parse(learnActDurationController.text);
    mqsLearnActivity[i].activity?.mqsActivityLessonDetail =
        learnActLessonDetailController.text.trim();
    mqsLearnActivity[i].activity?.mqsActivityReflectionQuestion =
        learnActRefQueController.text.trim();
    mqsLearnActivity[i].activity?.mqsActivityVideoLesson =
        learnActVideoLessonController.text.trim();
    mqsLearnActivity[i].activity?.mqsInfo =
        learnActMqsInfoController.text.trim();
    mqsLearnActivity[i].activity?.audio =
        learnAudio.value.isNotEmpty ? learnAudio.value : null;
    mqsLearnActivity[i].activity?.video =
        learnVideo.value.isNotEmpty ? learnVideo.value : null;
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
        mqsActivitySkill: pracActSkills,
        mqsActivityInstruction: pracActInstructionsController.text.trim(),
        mqsActivityReqIcons: pracActReqIcons,
        addToFav: pracActAddToFav.value,
        mqsActivityCompletionDate: pracActCompletionDateController.text,
        mqsActivityStatus: pracActStatus.value,
        activity: MqsPracticeActivityDetail(
          mqsActivityAudioLesson: pracActAudioLessonController.text.trim(),
          mqsActivityBenefits: pracActBenefitsController.text.trim(),
          mqsActivityCoachInstructions:
              pracActCoachInstructionsController.text.trim(),
          mqsActivityDuration: int.parse(pracActDurationController.text),
          mqsActivityLessonDetail: pracActLessonDetailController.text.trim(),
          mqsActivityReflectionQuestion: pracActRefQueController.text.trim(),
          mqsActivityVideoLesson: pracActVideoLessonController.text.trim(),
          mqsInfo: pracActMqsInfoController.text.trim(),
          mqsActivityUI: pracActUIController.text.trim(),
          audio: pracAudio.value.isNotEmpty ? pracAudio.value : null,
          video: pracVideo.value.isNotEmpty ? pracVideo.value : null,
        ),
      ),
    );
  }

  setPracActivtyForm({required int index}) {
    editPracActIndex.value = index;
    pracActIdController.text = mqsPracticeActivity[index].id;
    pracActRefIdController.text = mqsPracticeActivity[index].mqsActivityRefID;
    pracActTitleController.text = mqsPracticeActivity[index].mqsActivityTitle;
    pracActScreenHandoff.value =
        mqsPracticeActivity[index].mqsActivityScreenHandoff;
    pracActNavigateToScreenController.text =
        mqsPracticeActivity[index].mqsNavigateToScreen;
    pracActAddToFav.value = mqsPracticeActivity[index].addToFav;
    pracActStatus.value = mqsPracticeActivity[index].mqsActivityStatus;
    pracActCompletionDateController.text =
        mqsPracticeActivity[index].mqsActivityCompletionDate;
    pracActInstructionsController.text =
        mqsPracticeActivity[index].mqsActivityInstruction;
    pracActReqIcons.value =
        List<String>.from(mqsPracticeActivity[index].mqsActivityReqIcons);
    pracActSkills.value =
        List<String>.from(mqsPracticeActivity[index].mqsActivitySkill);
    pracActAudioLessonController.text =
        mqsPracticeActivity[index].activity?.mqsActivityAudioLesson ?? "";
    pracActBenefitsController.text =
        mqsPracticeActivity[index].activity?.mqsActivityBenefits ?? "";
    pracActCoachInstructionsController.text =
        mqsPracticeActivity[index].activity?.mqsActivityCoachInstructions ?? "";
    pracActDurationController.text =
        "${mqsPracticeActivity[index].activity?.mqsActivityDuration}";
    pracActLessonDetailController.text =
        mqsPracticeActivity[index].activity?.mqsActivityLessonDetail ?? "";
    pracActRefQueController.text =
        mqsPracticeActivity[index].activity?.mqsActivityReflectionQuestion ??
            "";
    pracActVideoLessonController.text =
        mqsPracticeActivity[index].activity?.mqsActivityVideoLesson ?? "";
    pracActMqsInfoController.text =
        mqsPracticeActivity[index].activity?.mqsInfo ?? "";
    pracActUIController.text =
        mqsPracticeActivity[index].activity?.mqsActivityUI ?? "";
    showPracActivity.value = true;
  }

  editPracActivity() {
    int i = editPracActIndex.value;
    mqsPracticeActivity[i].id = pracActIdController.text.trim();
    mqsPracticeActivity[i].mqsActivityRefID =
        pracActRefIdController.text.trim();
    mqsPracticeActivity[i].mqsActivityTitle =
        pracActTitleController.text.trim();
    mqsPracticeActivity[i].mqsActivityScreenHandoff =
        pracActScreenHandoff.value;
    mqsPracticeActivity[i].mqsNavigateToScreen =
        pracActNavigateToScreenController.text.trim();
    mqsPracticeActivity[i].mqsActivityInstruction =
        pracActInstructionsController.text.trim();
    mqsPracticeActivity[i].addToFav = pracActAddToFav.value;
    mqsPracticeActivity[i].mqsActivityStatus = pracActStatus.value;
    mqsPracticeActivity[i].mqsActivityCompletionDate =
        pracActCompletionDateController.text;
    mqsPracticeActivity[i].mqsActivityReqIcons = pracActReqIcons;
    mqsPracticeActivity[i].mqsActivitySkill = pracActSkills;
    mqsPracticeActivity[i].activity?.mqsActivityAudioLesson =
        pracActAudioLessonController.text.trim();
    mqsPracticeActivity[i].activity?.mqsActivityBenefits =
        pracActBenefitsController.text.trim();
    mqsPracticeActivity[i].activity?.mqsActivityCoachInstructions =
        pracActCoachInstructionsController.text.trim();
    mqsPracticeActivity[i].activity?.mqsActivityDuration =
        int.parse(pracActDurationController.text);
    mqsPracticeActivity[i].activity?.mqsActivityLessonDetail =
        pracActLessonDetailController.text.trim();
    mqsPracticeActivity[i].activity?.mqsActivityReflectionQuestion =
        pracActRefQueController.text.trim();
    mqsPracticeActivity[i].activity?.mqsActivityVideoLesson =
        pracActVideoLessonController.text.trim();
    mqsPracticeActivity[i].activity?.mqsInfo =
        pracActMqsInfoController.text.trim();
    mqsPracticeActivity[i].activity?.mqsActivityUI =
        pracActUIController.text.trim();
    mqsPracticeActivity[i].activity?.audio =
        pracAudio.value.isNotEmpty ? pracAudio.value : null;
    mqsPracticeActivity[i].activity?.video =
        pracVideo.value.isNotEmpty ? pracVideo.value : null;
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
        mqsLearnActivity: mqsLearnActivity,
        mqsPracticeActivity: mqsPracticeActivity,
        mqsModuleCompletionDate: moduleCompletionDateController.text,
        mqsPWModuleStatus: moduleStatus.value,
        image: moduleTileImage.value.isNotEmpty ? moduleTileImage.value : null,
      ),
    );
  }

  setModuleForm({required int index}) {
    editModuleIndex.value = index;
    moduleIdController.text = mqsModules[index].id;
    moduleTitleController.text = mqsModules[index].moduleTitle;
    moduleSubtitleController.text = mqsModules[index].mqsModuleSubtitle;
    moduleCompletionDateController.text =
        mqsModules[index].mqsModuleCompletionDate;
    moduleStatus.value = mqsModules[index].mqsPWModuleStatus;
    moduleTileImage.value = mqsModules[index].image ?? Uint8List(0);
    moduleTileImageURL.value = mqsModules[index].moduleTileImage;
    mqsLearnActivity.value =
        List<MqsLearnActivity>.from(mqsModules[index].mqsLearnActivity);
    mqsPracticeActivity.value =
        List<MqsPracticeActivity>.from(mqsModules[index].mqsPracticeActivity);
    showModules.value = true;
  }

  editModule() {
    int i = editModuleIndex.value;
    mqsModules[i].id = moduleIdController.text.trim();
    mqsModules[i].moduleTitle = moduleTitleController.text.trim();
    mqsModules[i].mqsModuleSubtitle = moduleSubtitleController.text.trim();
    mqsModules[i].mqsModuleCompletionDate = moduleCompletionDateController.text;
    mqsModules[i].mqsPWModuleStatus = moduleStatus.value;
    mqsModules[i].image =
        moduleTileImage.value.isNotEmpty ? moduleTileImage.value : null;
    mqsModules[i].mqsLearnActivity = mqsLearnActivity;
    mqsModules[i].mqsPracticeActivity = mqsPracticeActivity;
  }

  removeModule({required int index}) {
    mqsModules.removeAt(index);
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
    pathwayCompletionDateController.clear();
    selectedPathwayType.value = "";
    selectedUserID.value = "";
    pathwayStatus.value = false;
    aboutPathwayController.clear();
    learningObjController.clear();
    coachInstructionsController.clear();
    durationController.clear();
    levelController.clear();
    pathwayImage.value = Uint8List(0);
    pathwayIntroImage.value = Uint8List(0);
    pathwayTileImage.value = Uint8List(0);
    pathwayImageURL.value = "";
    pathwayIntroImageURL.value = "";
    pathwayTileImageURL.value = "";
    showModules.value = false;
    pathwayDep.clear();
    mqsModules.clear();
    clearModuleFields();
  }

  clearModuleFields() {
    showModules.value = false;
    moduleIdController.clear();
    moduleTitleController.clear();
    moduleSubtitleController.clear();
    moduleCompletionDateController.clear();
    moduleStatus.value = false;
    moduleTileImageURL.value = "";
    moduleTileImage.value = Uint8List(0);
    mqsLearnActivity.clear();
    mqsPracticeActivity.clear();
    clearLearnActivityFields();
    clearPracActivityFields();
    editModuleIndex.value = -1;
  }

  clearLearnActivityFields() {
    showLearnActivty.value = false;
    showLearnActSkills.value = false;
    learnActIdController.clear();
    learnActTitleController.clear();
    learnActNavigateToScreenController.clear();
    learnActAddToFav.value = false;
    learnActStatus.value = false;
    learnActCompletionDateController.clear();
    learnActRefIdController.clear();
    learnActRefQueController.clear();
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
    learnActSkills.clear();
    editLearnActIndex.value = -1;
  }

  clearPracActivityFields() {
    showPracActivity.value = false;
    showPracActSkills.value = false;
    showPracActReqIcons.value = false;
    pracActIdController.clear();
    pracActCoachInstructionsController.clear();
    pracActRefIdController.clear();
    pracActTitleController.clear();
    pracActNavigateToScreenController.clear();
    pracActAddToFav.value = false;
    pracActStatus.value = false;
    pracActCompletionDateController.clear();
    pracActInstructionsController.clear();
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
    pracActSkills.clear();
    pracActReqIcons.clear();
    editPracActIndex.value = -1;
  }

  // Store module tile images to firebase and set URL to parameter
  uploadModuleTileImages() async {
    try {
      for (int i = 0; i < mqsModules.length; i++) {
        if (mqsModules[i].image != null) {
          String url = await FirebaseStorageService.i
              .uploadFile(data: mqsModules[i].image!);
          mqsModules[i].moduleTileImage = url;
        }
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  // Store learn activity audio and video to firebase and set URL to parameter
  uploadLearnActAudioVideo() async {
    try {
      for (int i = 0; i < mqsLearnActivity.length; i++) {
        if (mqsLearnActivity[i].activity?.audio != null) {
          String url = await FirebaseStorageService.i.uploadFile(
              data: mqsLearnActivity[i].activity!.audio!, ext: 'mp3');
          mqsLearnActivity[i].activity?.mqsActivityAudioLesson = url;
        }
        if (mqsLearnActivity[i].activity?.video != null) {
          String url = await FirebaseStorageService.i.uploadFile(
              data: mqsLearnActivity[i].activity!.video!, ext: 'mp4');
          mqsLearnActivity[i].activity?.mqsActivityVideoLesson = url;
        }
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  // Store practice activity audio and video to firebase and set URL to parameter
  uploadPracActAudioVideo() async {
    try {
      for (int i = 0; i < mqsPracticeActivity.length; i++) {
        if (mqsPracticeActivity[i].activity?.audio != null) {
          String url = await FirebaseStorageService.i.uploadFile(
              data: mqsPracticeActivity[i].activity!.audio!, ext: 'mp3');
          mqsPracticeActivity[i].activity?.mqsActivityAudioLesson = url;
        }
        if (mqsPracticeActivity[i].activity?.video != null) {
          String url = await FirebaseStorageService.i.uploadFile(
              data: mqsPracticeActivity[i].activity!.video!, ext: 'mp4');
          mqsPracticeActivity[i].activity?.mqsActivityVideoLesson = url;
        }
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  addPathway() async {
    try {
      if (pathwayFormKey.currentState?.validate() ?? false) {
        final docRef = FirebaseStorageService.i.pathway.doc().id;
        showLoader();
        String pathwayImgURL = pathwayImageURL.value,
            pathwayIntroImgURL = pathwayIntroImageURL.value,
            pathwayTileImgURL = pathwayTileImageURL.value;
        if (pathwayImage.value.isNotEmpty) {
          pathwayImgURL = await FirebaseStorageService.i
              .uploadFile(data: pathwayImage.value);
        }
        if (pathwayIntroImage.value.isNotEmpty) {
          pathwayIntroImgURL = await FirebaseStorageService.i
              .uploadFile(data: pathwayIntroImage.value);
        }
        if (pathwayTileImage.value.isNotEmpty) {
          pathwayTileImgURL = await FirebaseStorageService.i
              .uploadFile(data: pathwayTileImage.value);
        }
        await uploadModuleTileImages();
        await uploadLearnActAudioVideo();
        await uploadPracActAudioVideo();
        final pathwayModel = MQSMyQPathwayModel(
          docId: docRef,
          id: idController.text.trim(),
          mqsPathwayTitle: titleController.text.trim(),
          mqsPathwaySubtitle: subtitleController.text.trim(),
          mqsPathwayType: selectedPathwayType.value,
          mqsAboutPathway: aboutPathwayController.text.trim(),
          mqsLearningObj: learningObjController.text.trim(),
          mqsPathwayCoachInstructions: coachInstructionsController.text.trim(),
          mqsPathwayImage: pathwayImgURL,
          mqsModuleCount: mqsModules.length,
          mqsPathwayDuration: durationController.text.trim(),
          mqsPathwayLevel: int.parse(levelController.text),
          mqsPathwayIntroImage: pathwayIntroImgURL,
          mqsPathwayTileImage: pathwayTileImgURL,
          mqsPathwayDep: pathwayDep,
          mqsPathwayDetail: MqsPathwayDetail(mqsModules: mqsModules),
          mqsPathwayStatus: pathwayStatus.value,
          mqsPathwayCompletionDate: pathwayCompletionDateController.text,
          mqsPathwayID: idController.text.trim(),
          mqsUserID: selectedUserID.value,
        );
        if (isEdit.value) {
          await PathwayRepository.i.editPathway(
              pathwayModel: pathwayModel, docId: pathwayDetail.docId);
        } else {
          await PathwayRepository.i
              .addPathway(pathwayModel: pathwayModel, customId: docRef);
        }
        hideLoader();
        clearAllFields();
        isAdd.value = false;
        isEdit.value = false;
        if (Get.currentRoute == AppRoutes.addPathway) {
          Get.back();
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  setPathwayForm() async {
    idController.text = pathwayDetail.id;
    titleController.text = pathwayDetail.mqsPathwayTitle;
    subtitleController.text = pathwayDetail.mqsPathwaySubtitle;
    pathwayCompletionDateController.text =
        pathwayDetail.mqsPathwayCompletionDate;
    selectedPathwayType.value = pathwayDetail.mqsPathwayType;
    selectedUserID.value =
        users.any((e) => e.mqsFirebaseUserID == pathwayDetail.mqsUserID)
            ? pathwayDetail.mqsUserID
            : "";
    pathwayStatus.value = pathwayDetail.mqsPathwayStatus;
    pathwayImageURL.value = pathwayDetail.mqsPathwayImage;
    pathwayIntroImageURL.value = pathwayDetail.mqsPathwayIntroImage;
    pathwayTileImageURL.value = pathwayDetail.mqsPathwayTileImage;
    aboutPathwayController.text = pathwayDetail.mqsAboutPathway;
    learningObjController.text = pathwayDetail.mqsLearningObj;
    coachInstructionsController.text =
        pathwayDetail.mqsPathwayCoachInstructions;
    durationController.text = pathwayDetail.mqsPathwayDuration;
    levelController.text = pathwayDetail.mqsPathwayLevel.toString();
    pathwayDep.value = List.from(pathwayDetail.mqsPathwayDep);
    mqsModules.value = List.from(modules);
  }

  // deleteStorageFiles() async {
  //   if (pathwayDetail.mqsPathwayImage.isNotEmpty) {
  //     await FirebaseStorageService.i
  //         .deleteFile(downloadURL: pathwayDetail.mqsPathwayImage);
  //   }
  //   if (pathwayDetail.mqsPathwayIntroImage.isNotEmpty) {
  //     await FirebaseStorageService.i
  //         .deleteFile(downloadURL: pathwayDetail.mqsPathwayIntroImage);
  //   }
  //   if (pathwayDetail.mqsPathwayTileImage.isNotEmpty) {
  //     await FirebaseStorageService.i
  //         .deleteFile(downloadURL: pathwayDetail.mqsPathwayTileImage);
  //   }
  //   for (MqsModule e in modules) {
  //     if (e.moduleTileImage.isNotEmpty) {
  //       await FirebaseStorageService.i
  //           .deleteFile(downloadURL: e.moduleTileImage);
  //     }
  //     // Delete audio and video files of all learn activities
  //     for (MqsLearnActivity action in e.mqsLearnActivity) {
  //       if ((action.activity?.mqsActivityAudioLesson ?? "").isNotEmpty) {
  //         await FirebaseStorageService.i.deleteFile(
  //             downloadURL: action.activity?.mqsActivityAudioLesson ?? "");
  //       }
  //       if ((action.activity?.mqsActivityVideoLesson ?? "").isNotEmpty) {
  //         await FirebaseStorageService.i.deleteFile(
  //             downloadURL: action.activity?.mqsActivityVideoLesson ?? "");
  //       }
  //     }
  //     // Delete audio and video files of all practice activities
  //     for (MqsPracticeActivity action in e.mqsPracticeActivity) {
  //       if ((action.activity?.mqsActivityAudioLesson ?? "").isNotEmpty) {
  //         await FirebaseStorageService.i.deleteFile(
  //             downloadURL: action.activity?.mqsActivityAudioLesson ?? "");
  //       }
  //       if ((action.activity?.mqsActivityVideoLesson ?? "").isNotEmpty) {
  //         await FirebaseStorageService.i.deleteFile(
  //             downloadURL: action.activity?.mqsActivityVideoLesson ?? "");
  //       }
  //     }
  //   }
  // }

  deletePathway({required String docId}) async {
    try {
      showLoader();
      isAdd.value = false;
      isEdit.value = false;
      // await deleteStorageFiles();
      await PathwayRepository.i.deletePathway(docId: docId);
      viewIndex.value = 0;
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
    try {
      List<List<dynamic>> rows = await FirebaseModelImportService.i.importCSV();
      if (rows.isNotEmpty) {
        List<String> headers = rows[0].map((e) => e.toString()).toList();
        for (int i = 1; i < rows.length; i++) {
          Map<String, dynamic> rowMap = {
            for (int j = 0; j < headers.length; j++) headers[j]: rows[i][j]
          };
          final docRef = FirebaseStorageService.i.pathway.doc().id;
          MQSMyQPathwayModel pathwayModel = MQSMyQPathwayModel(
            docId: docRef,
            id: rowMap[StringConfig.pathway.id].toString(),
            mqsPathwayTitle:
                rowMap[StringConfig.pathway.pathwayTitle].toString(),
            mqsPathwaySubtitle:
                rowMap[StringConfig.pathway.pathwaySubtitle].toString(),
            mqsPathwayType: rowMap[StringConfig.pathway.pathwayType].toString(),
            mqsAboutPathway:
                rowMap[StringConfig.pathway.aboutPathway].toString(),
            mqsLearningObj: rowMap[StringConfig.pathway.learningObj].toString(),
            mqsPathwayCoachInstructions:
                rowMap[StringConfig.pathway.pathwayCoachInstructions]
                    .toString(),
            mqsPathwayCompletionDate:
                rowMap[StringConfig.pathway.completionDate].toString(),
            mqsPathwayID: rowMap[StringConfig.pathway.pathwayID].toString(),
            mqsPathwayImage:
                rowMap[StringConfig.pathway.pathwayImage].toString(),
            mqsModuleCount: rowMap[StringConfig.pathway.moduleCount],
            mqsPathwayDuration:
                rowMap[StringConfig.pathway.pathwayDuration].toString(),
            mqsPathwayLevel: rowMap[StringConfig.pathway.pathwayLevel],
            mqsPathwayStatus: rowMap[StringConfig.pathway.pathwayStatus]
                    .toString()
                    .toLowerCase() ==
                StringConfig.dashboard.trueText.toLowerCase(),
            mqsPathwayIntroImage:
                rowMap[StringConfig.pathway.pathwayIntroImage].toString(),
            mqsPathwayTileImage:
                rowMap[StringConfig.pathway.pathwayTileImage].toString(),
            mqsPathwayDep:
                rowMap[StringConfig.pathway.pathwayDep].toString().split(", "),
            mqsPathwayDetail: MqsPathwayDetail(
              mqsModules:
                  (jsonDecode(rowMap[StringConfig.pathway.modules]) as List)
                      .map((e) => MqsModule.fromJson(e))
                      .toList(),
            ),
            mqsUserID: rowMap[StringConfig.pathway.userId].toString(),
          );
          await PathwayRepository.i
              .addPathway(pathwayModel: pathwayModel, customId: docRef);
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportPathway() async {
    try {
      List<List<String>> rows = [
        [
          StringConfig.pathway.id,
          StringConfig.pathway.pathwayTitle,
          StringConfig.pathway.pathwaySubtitle,
          StringConfig.pathway.pathwayType,
          StringConfig.pathway.aboutPathway,
          StringConfig.pathway.learningObj,
          StringConfig.pathway.moduleCount,
          StringConfig.pathway.pathwayCoachInstructions,
          StringConfig.pathway.completionDate,
          StringConfig.pathway.pathwayID,
          StringConfig.pathway.pathwayDep,
          StringConfig.pathway.pathwayDuration,
          StringConfig.pathway.pathwayImage,
          StringConfig.pathway.pathwayIntroImage,
          StringConfig.pathway.pathwayTileImage,
          StringConfig.pathway.pathwayLevel,
          StringConfig.pathway.pathwayStatus,
          StringConfig.pathway.modules,
          StringConfig.pathway.userId,
        ],
        ...pathway.map((model) {
          return [
            model.id,
            model.mqsPathwayTitle,
            model.mqsPathwaySubtitle,
            model.mqsPathwayType,
            model.mqsAboutPathway,
            model.mqsLearningObj,
            "${model.mqsModuleCount}",
            model.mqsPathwayCoachInstructions,
            model.mqsPathwayCompletionDate,
            model.mqsPathwayID,
            model.mqsPathwayDep.join(", "),
            model.mqsPathwayDuration,
            model.mqsPathwayImage,
            model.mqsPathwayIntroImage,
            model.mqsPathwayTileImage,
            "${model.mqsPathwayLevel}",
            "${model.mqsPathwayStatus}",
            jsonEncode(model.mqsPathwayDetail?.mqsModules
                    .map((p) => p.toJson())
                    .toList() ??
                []),
            model.mqsUserID,
          ];
        }),
      ];
      await FirebaseModelExportService.i.uploadFileToCSV(
          fileName: StringConfig.pathway.pathwayInformation, rows: rows);
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
