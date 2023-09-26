class BooksModel {
  BooksModel({
    required this.success,
    this.totalResults,
    required this.foundResults,
    required this.page,
    required this.entriesPerPage,
    required this.pdfLocation,
    required this.pdfImageLocation,
    required this.books,
    required this.addonBooks,
  });
  late final bool success;
  late final int? totalResults;
  late final int foundResults;
  late final int page;
  late final int entriesPerPage;
  late final String pdfLocation;
  late final String pdfImageLocation;
  late final List<Books> books;
  late final List<dynamic> addonBooks;

  BooksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalResults = json['total_results'];
    foundResults = json['found_results'];
    page = json['page'];
    entriesPerPage = json['entries_per_page'];
    pdfLocation = json['pdfLocation'];
    pdfImageLocation = json['pdfImageLocation'];
    books = List.from(json['books']).map((e) => Books.fromJson(e)).toList();
    addonBooks = List.castFrom<dynamic, dynamic>(json['addonBooks']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['total_results'] = totalResults;
    _data['found_results'] = foundResults;
    _data['page'] = page;
    _data['entries_per_page'] = entriesPerPage;
    _data['pdfLocation'] = pdfLocation;
    _data['pdfImageLocation'] = pdfImageLocation;
    _data['books'] = books.map((e) => e.toJson()).toList();
    _data['addonBooks'] = addonBooks;
    // print(_data);
    return _data;
  }
}

class Books {
  Books({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.description,
    required this.coverPhoto,
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
    required this.V,
  });
  late final String id;
  late final String title;
  late final List<String> category;
  late final String author;
  late final String description;
  late final String coverPhoto;
  late final List<double> ratings;
  late final List<String> raters;
  late final List<dynamic> favorite;
  late final List<dynamic> read;
  late final List<dynamic> download;
  late final bool free;
  late final String type;
  late final Pdf pdf;
  late final String packagePlan;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Books.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    category = List.castFrom<dynamic, String>(json['category']);
    author = json['author'];
    description = json['description'];
    coverPhoto = json['coverPhoto'];
    ratings = List.castFrom<dynamic, double>(json['ratings']);
    raters = List.castFrom<dynamic, String>(json['raters']);
    favorite = List.castFrom<dynamic, dynamic>(json['favorite']);
    read = List.castFrom<dynamic, dynamic>(json['read']);
    download = List.castFrom<dynamic, dynamic>(json['download']);
    free = json['free'];
    type = json['type'];
    pdf = Pdf.fromJson(json['pdf']);
    packagePlan = json['packagePlan'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['title'] = title;
    _data['category'] = category;
    _data['author'] = author;
    _data['description'] = description;
    _data['coverPhoto'] = coverPhoto;
    _data['ratings'] = ratings;
    _data['raters'] = raters;
    _data['favorite'] = favorite;
    _data['read'] = read;
    _data['download'] = download;
    _data['free'] = free;
    _data['type'] = type;
    _data['pdf'] = pdf.toJson();
    _data['packagePlan'] = packagePlan;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    print(_data);
    return _data;
  }
}

class Pdf {
  Pdf({
    required this.id,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String id;
  late final String file;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Pdf.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    file = json['file'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['file'] = file;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}
