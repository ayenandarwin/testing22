class VideoBooksModel {
  VideoBooksModel({
    required this.success,
    required this.totalResults,
    required this.foundResults,
    required this.page,
    required this.entriesPerPage,
    required this.videoBooks,
    required this.mp4Location,
    required this.mp4ImageLocation,
  });
  late final bool success;
  late final int totalResults;
  late final int foundResults;
  late final int page;
  late final int entriesPerPage;
  late final List<VideoBooks> videoBooks;
  late final String mp4Location;
  late final String mp4ImageLocation;

  VideoBooksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalResults = json['total_results'];
    foundResults = json['found_results'];
    page = json['page'];
    entriesPerPage = json['entries_per_page'];
    videoBooks = List.from(json['videoBooks'])
        .map((e) => VideoBooks.fromJson(e))
        .toList();
    mp4Location = json['mp4Location'];
    mp4ImageLocation = json['mp4ImageLocation'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['total_results'] = totalResults;
    data['found_results'] = foundResults;
    data['page'] = page;
    data['entries_per_page'] = entriesPerPage;
    data['videoBooks'] = videoBooks.map((e) => e.toJson()).toList();
    data['mp4Location'] = mp4Location;
    data['mp4ImageLocation'] = mp4ImageLocation;
    return data;
  }
}

class VideoBooks {
  VideoBooks({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.coverPhoto,
    required this.duration,
    required this.rate,
    required this.ratings,
    required this.raters,
    required this.favorite,
    required this.read,
    required this.download,
    required this.free,
    required this.type,
    required this.mp4,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String id;
  late final String title;
  late final List<String> category;
  late final String description;
  late final String coverPhoto;
  late final String duration;
  late final num? rate;
  late final List<num> ratings;
  late final List<String> raters;
  late final List<dynamic> favorite;
  late final List<dynamic> read;
  late final List<dynamic> download;
  late final bool free;
  late final String type;
  late final Mp4 mp4;
  late final String createdAt;
  late final String updatedAt;
  late final int? V;

  VideoBooks.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    category = List.castFrom<dynamic, String>(json['category']);
    description = json['description'];
    coverPhoto = json['coverPhoto'];
    duration = json['duration'];
    rate = json['rate'];
    ratings = List.castFrom<dynamic, double>(json['ratings']);
    raters = List.castFrom<dynamic, String>(json['raters']);
    favorite = List.castFrom<dynamic, dynamic>(json['favorite']);
    read = List.castFrom<dynamic, dynamic>(json['read']);
    download = List.castFrom<dynamic, dynamic>(json['download']);
    free = json['free'];
    type = json['type'];
    mp4 = Mp4.fromJson(json['mp4']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['description'] = description;
    data['coverPhoto'] = coverPhoto;
    data['duration'] = duration;
    data['rate'] = rate;
    data['ratings'] = ratings;
    data['raters'] = raters;
    data['favorite'] = favorite;
    data['read'] = read;
    data['download'] = download;
    data['free'] = free;
    data['type'] = type;
    data['mp4'] = mp4.toJson();
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = V;
    return data;
  }
}

class Mp4 {
  Mp4({
    required this.id,
    required this.file,
    required this.videoType,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String id;
  late final String file;
  late final String videoType;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Mp4.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    file = json['file'];
    videoType = json['videoType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['file'] = file;
    data['videoType'] = videoType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = V;
    return data;
  }
}
