class ApiResult {
  int code = 0;
  String message = "";
  Map<String, dynamic> parsed;

  ApiResult(this.parsed) {
    code = parsed['code'];
    message = parsed['message'];
  }

  factory ApiResult.of(Map<String, dynamic> response) {
    return ApiResult(response);
  }

  factory ApiResult.error(e) {
    return ApiResult({'code': 0, 'message': e.toString()});
  }

  bool isSuccess() {
    return code == 100000;
  }

  dynamic getData() {
    return parsed['data'];
  }

  List<O> getDataList<O, I>(O function(Map<String, dynamic> value)) {
    var data = getData();
    if (data == null) {
      return <O>[];
    } else {
      return (data as List<dynamic>).map((m) => function(m)).toList();
    }
  }
}
