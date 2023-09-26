// To parse this JSON data, do
//
//     final addsModel = addsModelFromJson(jsonString);

import 'dart:convert';

AddsModel addsModelFromJson(String str) => AddsModel.fromJson(json.decode(str));

String addsModelToJson(AddsModel data) => json.encode(data.toJson());

class AddsModel {
  bool success;
  List<Add>? adds;
  String? msg;

  AddsModel({
    required this.success,
    this.adds,
    this.msg,
  });

  factory AddsModel.fromJson(Map<String, dynamic> json) => AddsModel(
        success: json["success"],
        adds: List<Add>.from(json["adds"].map((x) => Add.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "adds": List<dynamic>.from(adds!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Add {
  String id;
  String link;
  String image;
  String title;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Add({
    required this.id,
    required this.link,
    required this.image,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Add.fromJson(Map<String, dynamic> json) => Add(
        id: json["_id"],
        link: json["link"],
        image: json["image"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "link": link,
        "image": image,
        "title": title,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
