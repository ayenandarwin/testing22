// To parse this JSON data, do
//
//     final downloadModel = downloadModelFromJson(jsonString);

import 'dart:convert';

DownloadModel downloadModelFromJson(String str) =>
    DownloadModel.fromJson(json.decode(str));

String downloadModelToJson(DownloadModel data) => json.encode(data.toJson());

class DownloadModel {
  bool success;
  List<Download> downloads;

  DownloadModel({
    required this.success,
    required this.downloads,
  });

  factory DownloadModel.fromJson(Map<String, dynamic> json) => DownloadModel(
        success: json["success"],
        downloads: List<Download>.from(
            json["downloads"].map((x) => Download.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "downloads": List<dynamic>.from(downloads.map((x) => x.toJson())),
      };
}

class Download {
  String id;
  String userId;
  List<Audio> book;
  List<Audio> audio;
  List<dynamic> video;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Download({
    required this.id,
    required this.userId,
    required this.book,
    required this.audio,
    required this.video,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Download.fromJson(Map<String, dynamic> json) => Download(
        id: json["_id"],
        userId: json["userId"],
        book: List<Audio>.from(json["book"].map((x) => Audio.fromJson(x))),
        audio: List<Audio>.from(json["audio"].map((x) => Audio.fromJson(x))),
        video: List<dynamic>.from(json["video"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "book": List<dynamic>.from(book.map((x) => x.toJson())),
        "audio": List<dynamic>.from(audio.map((x) => x.toJson())),
        "video": List<dynamic>.from(video.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Audio {
  String id;
  String title;
  List<String> category;
  String author;
  String description;
  String coverPhoto;
  String? duration;
  double rate;
  List<double> ratings;
  List<String> raters;
  List<String> favorite;
  List<String> read;
  List<String> download;
  bool free;
  String type;
  String? mp3;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? pdf;
  String? packagePlan;

  Audio({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.description,
    required this.coverPhoto,
    this.duration,
    required this.rate,
    required this.ratings,
    required this.raters,
    required this.favorite,
    required this.read,
    required this.download,
    required this.free,
    required this.type,
    this.mp3,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.pdf,
    this.packagePlan,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        id: json["_id"],
        title: json["title"],
        category: List<String>.from(json["category"].map((x) => x)),
        author: json["author"],
        description: json["description"],
        coverPhoto: json["coverPhoto"],
        duration: json["duration"],
        rate: json["rate"]?.toDouble(),
        ratings: List<double>.from(json["ratings"].map((x) => x?.toDouble())),
        raters: List<String>.from(json["raters"].map((x) => x)),
        favorite: List<String>.from(json["favorite"].map((x) => x)),
        read: List<String>.from(json["read"].map((x) => x)),
        download: List<String>.from(json["download"].map((x) => x)),
        free: json["free"],
        type: json["type"],
        mp3: json["mp3"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        pdf: json["pdf"],
        packagePlan: json["packagePlan"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "category": List<dynamic>.from(category.map((x) => x)),
        "author": author,
        "description": description,
        "coverPhoto": coverPhoto,
        "duration": duration,
        "rate": rate,
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
        "raters": List<dynamic>.from(raters.map((x) => x)),
        "favorite": List<dynamic>.from(favorite.map((x) => x)),
        "read": List<dynamic>.from(read.map((x) => x)),
        "download": List<dynamic>.from(download.map((x) => x)),
        "free": free,
        "type": type,
        "mp3": mp3,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "pdf": pdf,
        "packagePlan": packagePlan,
      };
}
