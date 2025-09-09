class Otp {
  final int code;
  final String message;
  final String status;

  Otp({required this.code, required this.message, required this.status});

  factory Otp.fromJson(Map<String, dynamic> json) {
    return Otp(
      code: json['code'],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'status': status};
  }
}
