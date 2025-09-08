import 'package:maxbazaar/features/auth/domain/entities/user.dart';

class LoginModel extends Login {
  const LoginModel({
    required super.code,
    required super.message,
    super.refresh,
    super.access,
    required super.role,
    required super.userId,
    super.email,
    super.gender,
    super.pincode,
    super.firstName,
    super.lastName,
    required super.phoneNo,
    super.address,
    super.state,
    super.city,
    super.profile,
    required super.isActive,
    required super.myReferal,
    super.byReferal,
    required super.registrationDate,
    super.dateOfBirth,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      refresh: json['refresh']?.toString(),
      access: json['access']?.toString(),
      role: json['role'] ?? '',
      userId: json['userid'] ?? 0,
      email: json['email']?.toString(),
      gender: json['gender']?.toString(),
      pincode: json['pincode']?.toString(),
      firstName: json['first_name']?.toString(),
      lastName: json['last_name']?.toString(),
      phoneNo: json['phone_no']?.toString() ?? '',
      address: json['address']?.toString(),
      state: json['state']?.toString(),
      city: json['city']?.toString(),
      profile: json['profile']?.toString(),
      isActive: json['isactive'] ?? false,
      myReferal: json['my_referal']?.toString() ?? '',
      byReferal: json['by_referal']?.toString(),
      registrationDate: json['registration_date']?.toString() ?? '',
      dateOfBirth: json['date_of_birth']?.toString(),
    );
  }
}

// import '../../domain/entities/user.dart';

// class UserModel extends User {
//   const UserModel({
//     required super.id,
//     required super.username,
//     required super.email,
//     required super.accessToken,
//     required super.refreshToken,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     final access = (json['token'] ?? json['accessToken'] ?? '').toString();
//     final refresh = (json['refreshToken'] ?? '').toString();

//     return UserModel(
//       id: json['id'] is int
//           ? json['id'] as int
//           : int.tryParse('${json['id']}') ?? 0,
//       username: '${json['username'] ?? ''}',
//       email: '${json['email'] ?? ''}',
//       accessToken: access,
//       refreshToken: refresh,
//     );
//   }
// }
