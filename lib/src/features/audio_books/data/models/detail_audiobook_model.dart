class AudioBooksDetail {
  AudioBooksDetail({
    required this.success,
    required this.audioBook,
    required this.mp3Location,
  });
  late final bool? success;
  late final AudioBook? audioBook;
  late final String? mp3Location;

  AudioBooksDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    audioBook = AudioBook.fromJson(json['audioBook']);
    mp3Location = json['mp3Location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['audioBook'] = audioBook!.toJson();
    data['mp3Location'] = mp3Location;
    return data;
  }
}

class AudioBook {
  AudioBook({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
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
    required this.mp3,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String? id;
  late final String? title;
  late final List<String>? category;
  late final String? author;
  late final String? description;
  late final String? coverPhoto;
  late final String? duration;
  late final num? rate;
  late final List<double>? ratings;
  late final List<String>? raters;
  late final List<dynamic>? favorite;
  late final List<dynamic>? read;
  late final List<dynamic>? download;
  late final bool? free;
  late final String? type;
  late final Mp3? mp3;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? V;

  AudioBook.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    category = List.castFrom<dynamic, String>(json['category']);
    author = json['author'];
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
    mp3 = Mp3.fromJson(json['mp3']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['author'] = author;
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
    data['mp3'] = mp3!.toJson();
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = V;
    return data;
  }
}

class Mp3 {
  Mp3({
    required this.id,
    required this.file,
    required this.summary,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String? id;
  late final String? file;
  late final String? summary;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? V;

  Mp3.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    file = json['file'];
    summary = json['summary'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['file'] = file;
    data['summary'] = summary;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = V;
    return data;
  }
}
