class VideoBookDetailModel {
  VideoBookDetailModel({
    required this.success,
    required this.videoBook,
    required this.mp4Location,
  });
  late final bool success;
  late final VideoBook videoBook;
  late final String mp4Location;

  VideoBookDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    videoBook = VideoBook.fromJson(json['videoBook']);
    mp4Location = json['mp4Location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['videoBook'] = videoBook.toJson();
    data['mp4Location'] = mp4Location;
    return data;
  }
}

class VideoBook {
  VideoBook({
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
  late final num rate;
  late final List<int> ratings;
  late final List<String> raters;
  late final List<dynamic> favorite;
  late final List<dynamic> read;
  late final List<dynamic> download;
  late final bool free;
  late final String type;
  late final Mp4 mp4;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  VideoBook.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    category = List.castFrom<dynamic, String>(json['category']);
    description = json['description'];
    coverPhoto = json['coverPhoto'];
    duration = json['duration'];
    rate = json['rate'];
    ratings = List.castFrom<dynamic, int>(json['ratings']);
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
