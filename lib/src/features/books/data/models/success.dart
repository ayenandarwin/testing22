// class Success {
//   final String success;
//   final String msg;

//   Success(
//     this.success,
//     this.msg,
//   );
// }

class Success {
  Success({
    required this.success,
    required this.msg,
  });
  late final bool success;
  late final String msg;

  Success.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['total_results'] = msg;
    return data;
  }
}
