class MqsCircleFlaggedPostModel {
  String? posterUserId;
  CircleData? circleData;
  String? flagName;
  String? flagUserId;

  MqsCircleFlaggedPostModel(
      {this.posterUserId, this.circleData, this.flagName, this.flagUserId});

  MqsCircleFlaggedPostModel.fromJson(Map<String, dynamic> json) {
    posterUserId = json['poster_user_id'];
    circleData = json['circleData'] != null
        ? CircleData.fromJson(json['circleData'])
        : null;
    flagName = json['flag_name'];
    flagUserId = json['flag_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poster_user_id'] = posterUserId;
    if (circleData != null) {
      data['circleData'] = circleData!.toJson();
    }
    data['flag_name'] = flagName;
    data['flag_user_id'] = flagUserId;
    return data;
  }
}

class CircleData {
  int? postView;
  bool? isFlag;
  bool? isMainPost;
  String? postContent;
  String? postTitle;
  bool? userIsGuide;
  String? flagName;
  String? postTime;
  String? userId;
  String? userName;
  List<Hashtag>? hashtag;
  List<String>? postReply;

  CircleData(
      {this.postView,
      this.isFlag,
      this.isMainPost,
      this.postContent,
      this.postTitle,
      this.userIsGuide,
      this.flagName,
      this.postTime,
      this.userId,
      this.userName,
      this.hashtag,
      this.postReply});

  CircleData.fromJson(Map<String, dynamic> json) {
    postView = json['post_view'];
    isFlag = json['isFlag'];
    isMainPost = json['isMainPost'];
    postContent = json['post_content'];
    postTitle = json['post_title'];
    userIsGuide = json['userIsGuide'];
    flagName = json['flag_name'];
    postTime = json['post_time'];
    userId = json['user_id'];
    userName = json['user_name'];
    if (json['hashtag'] != null) {
      hashtag = <Hashtag>[];
      json['hashtag'].forEach((v) {
        hashtag!.add(Hashtag.fromJson(v));
      });
    }
    postReply =
        json['post_reply'] != null ? List<String>.from(json['post_reply']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_view'] = postView;
    data['isFlag'] = isFlag;
    data['isMainPost'] = isMainPost;
    data['post_content'] = postContent;
    data['post_title'] = postTitle;
    data['userIsGuide'] = userIsGuide;
    data['flag_name'] = flagName;
    data['post_time'] = postTime;
    data['user_id'] = userId;
    data['user_name'] = userName;
    if (hashtag != null) {
      data['hashtag'] = hashtag!.map((v) => v.toJson()).toList();
    }
    data['post_reply'] = postReply;
    return data;
  }
}

class Hashtag {
  int? id;
  String? name;

  Hashtag({this.id, this.name});

  Hashtag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
