class CircleModel {
  String? id;
  bool? isMainPost;
  bool? userIsGuide;
  bool? isFlag;
  String? flagName;
  String? userId;
  String? userName;
  String? postTime;
  int? postView;
  String? postTitle;
  String? postContent;
  List<Hashtag>? hashtag;
  List<String>? postReply;

  CircleModel(
      {this.id,
      this.userId,
      this.userIsGuide,
      this.isFlag,
      this.flagName,
      this.isMainPost,
      this.userName,
      this.postTime,
      this.postView,
      this.postTitle,
      this.postContent,
      this.hashtag,
      this.postReply});

  CircleModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userId = json['user_id'];
    isMainPost = json['isMainPost'];
    userIsGuide = json['userIsGuide'];
    isFlag = json['isFlag'];
    flagName = json['flag_name'];
    postTime = json['post_time'];
    postView = json['post_view'];
    postTitle = json['post_title'];
    postContent = json['post_content'];
    if (json['hashtag'] != null) {
      hashtag = <Hashtag>[];
      json['hashtag'].forEach((v) {
        hashtag!.add(Hashtag.fromJson(v));
      });
    }
    if (json['post_reply'] != null) {
      postReply = <String>[];
      json['post_reply'].forEach((v) {
        postReply!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['user_id'] = userId;
    data['isMainPost'] = isMainPost;
    data['userIsGuide'] = userIsGuide;
    data['isFlag'] = isFlag;
    data['flag_name'] = flagName;
    data['post_time'] = postTime;
    data['post_view'] = postView;
    data['post_title'] = postTitle;
    data['post_content'] = postContent;
    if (hashtag != null) {
      data['hashtag'] = hashtag?.map((v) => v.toJson()).toList();
    }
    if (postReply != null) {
      data['post_reply'] = postReply?.map((v) => v).toList();
    }
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
