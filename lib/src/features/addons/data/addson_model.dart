// To parse this JSON data, do
//
//     final addsonModel = addsonModelFromJson(jsonString);

import 'dart:convert';

AddsonModel addsonModelFromJson(String str) =>
    AddsonModel.fromJson(json.decode(str));

String addsonModelToJson(AddsonModel data) => json.encode(data.toJson());

class AddsonModel {
  bool success;
  int totalResults;
  int foundResults;
  int page;
  int entriesPerPage;
  List<Addon> addons;

  AddsonModel({
    required this.success,
    required this.totalResults,
    required this.foundResults,
    required this.page,
    required this.entriesPerPage,
    required this.addons,
  });

  factory AddsonModel.fromJson(Map<String, dynamic> json) => AddsonModel(
        success: json["success"],
        totalResults: json["total_results"],
        foundResults: json["found_results"],
        page: json["page"],
        entriesPerPage: json["entries_per_page"],
        addons: List<Addon>.from(json["addons"].map((x) => Addon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "total_results": totalResults,
        "found_results": foundResults,
        "page": page,
        "entries_per_page": entriesPerPage,
        "addons": List<dynamic>.from(addons.map((x) => x.toJson())),
      };
}

class Addon {
  String id;
  String name;
  int price;
  int month;
  String description;
  List<Book> books;
  List<String> users;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Addon({
    required this.id,
    required this.name,
    required this.price,
    required this.month,
    required this.description,
    required this.books,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        month: json["month"],
        description: json["description"],
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        users: List<String>.from(json["users"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "month": month,
        "description": description,
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Book {
  String id;
  String title;
  List<String> category;
  String author;
  String description;
  String coverPhoto;
  double rate;
  List<double> ratings;
  List<String> raters;
  List<dynamic> favorite;
  List<dynamic> read;
  List<dynamic> download;
  bool free;
  String type;
  String pdf;
  String packagePlan;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.description,
    required this.coverPhoto,
    required this.rate,
    required this.ratings,
    required this.raters,
    required this.favorite,
    required this.read,
    required this.download,
    required this.free,
    required this.type,
    required this.pdf,
    required this.packagePlan,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["_id"],
        title: json["title"],
        category: List<String>.from(json["category"].map((x) => x)),
        author: json["author"],
        description: json["description"],
        coverPhoto: json["coverPhoto"],
        rate: json["rate"]?.toDouble(),
        ratings: List<double>.from(json["ratings"].map((x) => x?.toDouble())),
        raters: List<String>.from(json["raters"].map((x) => x)),
        favorite: List<dynamic>.from(json["favorite"].map((x) => x)),
        read: List<dynamic>.from(json["read"].map((x) => x)),
        download: List<dynamic>.from(json["download"].map((x) => x)),
        free: json["free"],
        type: json["type"],
        pdf: json["pdf"],
        packagePlan: json["packagePlan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "category": List<dynamic>.from(category.map((x) => x)),
        "author": author,
        "description": description,
        "coverPhoto": coverPhoto,
        "rate": rate,
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
        "raters": List<dynamic>.from(raters.map((x) => x)),
        "favorite": List<dynamic>.from(favorite.map((x) => x)),
        "read": List<dynamic>.from(read.map((x) => x)),
        "download": List<dynamic>.from(download.map((x) => x)),
        "free": free,
        "type": type,
        "pdf": pdf,
        "packagePlan": packagePlan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
