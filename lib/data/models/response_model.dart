class ResponseModel {
  ResponseModel({
    this.code,
    this.success,
    this.message,
    this.data,
  });

  int? code;
  final bool? success;
  String? message;
  dynamic data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "data": data,
      };
}
