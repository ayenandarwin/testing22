// To parse this JSON data, do
//
//     final pricingModel = pricingModelFromJson(jsonString);

import 'dart:convert';

PricingModel pricingModelFromJson(String str) =>
    PricingModel.fromJson(json.decode(str));

String pricingModelToJson(PricingModel data) => json.encode(data.toJson());

class PricingModel {
  bool success;
  int totalResults;
  int foundResults;
  int page;
  int entriesPerPage;
  List<Package> packages;

  PricingModel({
    required this.success,
    required this.totalResults,
    required this.foundResults,
    required this.page,
    required this.entriesPerPage,
    required this.packages,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) => PricingModel(
        success: json["success"],
        totalResults: json["total_results"],
        foundResults: json["found_results"],
        page: json["page"],
        entriesPerPage: json["entries_per_page"],
        packages: List<Package>.from(
            json["packages"].map((x) => Package.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "total_results": totalResults,
        "found_results": foundResults,
        "page": page,
        "entries_per_page": entriesPerPage,
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
      };
}

class Package {
  String id;
  String name;
  int month;
  String description;
  int price;
  List<String> users;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Package({
    required this.id,
    required this.name,
    required this.month,
    required this.description,
    required this.price,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["_id"],
        name: json["name"],
        month: json["month"],
        description: json["description"],
        price: json["price"],
        users: List<String>.from(json["users"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "month": month,
        "description": description,
        "price": price,
        "users": List<dynamic>.from(users.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
