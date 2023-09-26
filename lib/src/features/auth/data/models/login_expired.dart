// To parse this JSON data, do
//
//     final loginExpired = loginExpiredFromJson(jsonString);

import 'dart:convert';

LoginExpired loginExpiredFromJson(String str) =>
    LoginExpired.fromJson(json.decode(str));

String loginExpiredToJson(LoginExpired data) => json.encode(data.toJson());

class LoginExpired {
  bool success;
  String? msg;

  LoginExpired({
    required this.success,
    this.msg,
  });

  factory LoginExpired.fromJson(Map<String, dynamic> json) => LoginExpired(
        success: json["success"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
      };
}
