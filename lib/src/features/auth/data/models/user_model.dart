// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  bool success;
  Data data;
  String token;
  String expires;

  UserData({
    required this.success,
    required this.data,
    required this.token,
    required this.expires,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
        expires: json["expires"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "token": token,
        "expires": expires,
      };
}

class Data {
  String id;
  String name;
  String email;
  DateTime dob;
  String role;
  String phone;
  dynamic profileImage;
  dynamic thirdParty;
  String status;
  bool premium;
  String deviceId;
  bool addon;
  List<dynamic> currentAddon;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<Notification> notifications;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.role,
    required this.phone,
    this.profileImage,
    this.thirdParty,
    required this.status,
    required this.premium,
    required this.deviceId,
    required this.addon,
    required this.currentAddon,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        dob: DateTime.parse(json["dob"]),
        role: json["role"],
        phone: json["phone"],
        profileImage: json["profileImage"],
        thirdParty: json["thirdParty"],
        status: json["status"],
        premium: json["premium"],
        deviceId: json["deviceId"],
        addon: json["addon"],
        currentAddon: List<dynamic>.from(json["currentAddon"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "role": role,
        "phone": phone,
        "profileImage": profileImage,
        "thirdParty": thirdParty,
        "status": status,
        "premium": premium,
        "deviceId": deviceId,
        "addon": addon,
        "currentAddon": List<dynamic>.from(currentAddon.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class Notification {
  String title;
  String body;
  bool read;

  Notification({
    required this.title,
    required this.body,
    required this.read,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"],
        body: json["body"],
        read: json["read"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "read": read,
      };
}
