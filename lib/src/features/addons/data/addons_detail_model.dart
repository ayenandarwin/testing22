// To parse this JSON data, do
//
//     final addsonDetailModel = addsonDetailModelFromJson(jsonString);

import 'dart:convert';

AddsonDetailModel addsonDetailModelFromJson(String str) =>
    AddsonDetailModel.fromJson(json.decode(str));

String addsonDetailModelToJson(AddsonDetailModel data) =>
    json.encode(data.toJson());

class AddsonDetailModel {
  bool success;
  Addon addon;

  AddsonDetailModel({
    required this.success,
    required this.addon,
  });

  factory AddsonDetailModel.fromJson(Map<String, dynamic> json) =>
      AddsonDetailModel(
        success: json["success"],
        addon: Addon.fromJson(json["addon"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "addon": addon.toJson(),
      };
}

class Addon {
  String id;
  String name;
  int price;
  int month;
  String description;
  List<Book> books;
  List<User> users;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  Pagination userPagination;
  Pagination bookPagination;

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
    required this.userPagination,
    required this.bookPagination,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        month: json["month"],
        description: json["description"],
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userPagination: Pagination.fromJson(json["userPagination"]),
        bookPagination: Pagination.fromJson(json["bookPagination"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "month": month,
        "description": description,
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "userPagination": userPagination.toJson(),
        "bookPagination": bookPagination.toJson(),
      };
}

class Pagination {
  int totalResults;
  int foundResults;
  int entriesPerPage;
  int page;

  Pagination({
    required this.totalResults,
    required this.foundResults,
    required this.entriesPerPage,
    required this.page,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalResults: json["total_results"],
        foundResults: json["found_results"],
        entriesPerPage: json["entries_per_page"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "total_results": totalResults,
        "found_results": foundResults,
        "entries_per_page": entriesPerPage,
        "page": page,
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

class User {
  String id;
  String name;
  String email;
  String password;
  DateTime? dob;
  String role;
  String phone;
  dynamic profileImage;
  String? thirdParty;
  String? thirdPartyToken;
  String status;
  bool premium;
  String deviceId;
  bool addon;
  List<CurrentAddon> currentAddon;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? salt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.dob,
    required this.role,
    required this.phone,
    this.profileImage,
    this.thirdParty,
    this.thirdPartyToken,
    required this.status,
    required this.premium,
    required this.deviceId,
    required this.addon,
    required this.currentAddon,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.salt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        role: json["role"],
        phone: json["phone"],
        profileImage: json["profileImage"],
        thirdParty: json["thirdParty"],
        thirdPartyToken: json["thirdPartyToken"],
        status: json["status"],
        premium: json["premium"],
        deviceId: json["deviceId"],
        addon: json["addon"],
        currentAddon: List<CurrentAddon>.from(
            json["currentAddon"].map((x) => CurrentAddon.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        salt: json["salt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "role": role,
        "phone": phone,
        "profileImage": profileImage,
        "thirdParty": thirdParty,
        "thirdPartyToken": thirdPartyToken,
        "status": status,
        "premium": premium,
        "deviceId": deviceId,
        "addon": addon,
        "currentAddon": List<dynamic>.from(currentAddon.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "salt": salt,
      };
}

class CurrentAddon {
  String addon;
  DateTime addonStartDate;
  DateTime addonExpiresAt;

  CurrentAddon({
    required this.addon,
    required this.addonStartDate,
    required this.addonExpiresAt,
  });

  factory CurrentAddon.fromJson(Map<String, dynamic> json) => CurrentAddon(
        addon: json["addon"],
        addonStartDate: DateTime.parse(json["addonStartDate"]),
        addonExpiresAt: DateTime.parse(json["addonExpiresAt"]),
      );

  Map<String, dynamic> toJson() => {
        "addon": addon,
        "addonStartDate": addonStartDate.toIso8601String(),
        "addonExpiresAt": addonExpiresAt.toIso8601String(),
      };
}
