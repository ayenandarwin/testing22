class PopularBooksModel {
  PopularBooksModel({
    required this.success,
    required this.totalResults,
    required this.foundResults,
    required this.entriesPerPage,
    required this.page,
    required this.books,
  });
  late final bool success;
  late final int totalResults;
  late final int foundResults;
  late final int entriesPerPage;
  late final int page;
  late final List<Books> books;

  PopularBooksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalResults = json['total_results'];
    foundResults = json['found_results'];
    entriesPerPage = json['entries_per_page'];
    page = json['page'];
    books = List.from(json['books']).map((e) => Books.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['total_results'] = totalResults;
    data['found_results'] = foundResults;
    data['entries_per_page'] = entriesPerPage;
    data['page'] = page;
    data['books'] = books.map((e) => e.toJson()).toList();
    return data;
  }
}

class Books {
  Books({
    required this.id,
    required this.title,
    required this.author,
    required this.coverPhoto,
    required this.rate,
    required this.read,
    required this.favorite,
    required this.download,
    required this.free,
    required this.packagePlan,
    required this.readCount,
  });
  late final String id;
  late final String title;
  late final String author;
  late final String coverPhoto;
  late final double rate;
  late final String read;
  late final List<dynamic> favorite;
  late final List<dynamic> download;
  late final bool free;
  late final String packagePlan;
  late final int readCount;

  Books.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    author = json['author'];
    coverPhoto = json['coverPhoto'];
    rate = json['rate'];
    read = json['read'];
    favorite = List.castFrom<dynamic, dynamic>(json['favorite']);
    download = List.castFrom<dynamic, dynamic>(json['download']);
    free = json['free'];
    packagePlan = json['packagePlan'];
    readCount = json['readCount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['coverPhoto'] = coverPhoto;
    data['rate'] = rate;
    data['read'] = read;
    data['favorite'] = favorite;
    data['download'] = download;
    data['free'] = free;
    data['packagePlan'] = packagePlan;
    data['readCount'] = readCount;
    return data;
  }
}
