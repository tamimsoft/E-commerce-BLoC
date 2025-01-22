class ApiResponse {
  final String? msg;
  final dynamic data;

  ApiResponse({
    this.msg,
    this.data,
  });

  // Factory constructor to create an ApiResponse object from a JSON map
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      msg: json['msg'] ?? '',
      data: json['data'] ?? '',
    );
  }
}
