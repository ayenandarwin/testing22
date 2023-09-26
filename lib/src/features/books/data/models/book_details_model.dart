class BookDetails {
  BookDetails({
    required this.success,
    required this.pdfLocation,
    required this.book,
  });
  late final bool success;
  late final String pdfLocation;
  late final Book book;

  BookDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    pdfLocation = json['pdfLocation'];
    book = Book.fromJson(json['book']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['pdfLocation'] = pdfLocation;
    _data['book'] = book.toJson();
    return _data;
  }
}

class Book {
  Book({
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

  Book.fromJson(Map<String, dynamic> json) {
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
