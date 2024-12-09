import 'from_user_model.dart';

class NotesPlistModel {
  String? id;
  String? type;
  String? title;
  String? textContent;
  dynamic urls; // 根据实际情况调整类型
  int? views;
  int? likes;
  int? disLikes;
  dynamic comments; // 根据实际情况调整类型
  List<dynamic> commentList;
  List<dynamic> likeList;
  FromUserModel? fromUser; // 使用之前定义的 UserMmwModel
  dynamic toPost; // 根据实际情况调整类型
  DateTime? createAt; // 假设创建时间是 DateTime 类型
  bool? liked;

  NotesPlistModel({
    this.id,
    this.type,
    this.title,
    this.textContent,
    this.urls,
    this.views,
    this.likes,
    this.disLikes,
    this.comments,
    List<dynamic>? commentList,
    List<dynamic>? likeList,
    this.fromUser,
    this.toPost,
    this.createAt,
    this.liked,
  })  : commentList = commentList ?? [],
        likeList = likeList ?? [];

  // 从 JSON 构造 PlistModel
  NotesPlistModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        title = json['title'],
        textContent = json['textContent'],
        urls = json['urls'],
        views = json['views'],
        likes = json['likes'],
        disLikes = json['disLikes'],
        comments = json['comments'],
        commentList = List<dynamic>.from(json['commentList'] ?? []),
        likeList = List<dynamic>.from(json['likeList'] ?? []),
        fromUser = json['fromUser'] != null
            ? FromUserModel.fromJson(json['fromUser'])
            : null,
        toPost = json['toPost'],
        createAt =
            json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
        liked = json['liked'];

  // 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'textContent': textContent,
      'urls': urls,
      'views': views,
      'likes': likes,
      'disLikes': disLikes,
      'comments': comments,
      'commentList': commentList,
      'likeList': likeList,
      'fromUser': fromUser?.toJson(),
      'toPost': toPost,
      'createAt': createAt?.toIso8601String(),
      'liked': liked,
    };
  }

  @override
  String toString() {
    return 'NotesPlistModel{id: $id, type: $type, title: $title, textContent: $textContent, urls: $urls, views: $views, likes: $likes, disLikes: $disLikes, comments: $comments, commentList: $commentList, likeList: $likeList, fromUser: $fromUser, toPost: $toPost, createAt: $createAt, liked: $liked}';
  }
}
