// import 'package:maxbiz_app/features/auth/domain/entities/user.dart';

// class LoginModel extends Login {
//   LoginModel({
//     required super.code,
//     required super.message,
//     required super.refresh,
//     required super.access,
//     required super.role,
//     required super.userId,
//     super.email,
//     super.gender,
//     super.pincode,
//     super.firstName,
//     super.lastName,
//     required super.phoneNo,
//     super.address,
//     super.state,
//     super.city,
//     super.profile,
//     required super.isActive,
//     required super.myReferal,
//     super.byReferal,
//     required super.registrationDate,
//     super.dateOfBirth,
//   });

//   factory LoginModel.fromJson(Map<String, dynamic> json) {
//     return LoginModel(
//       code: json['code'],
//       message: json['message'],
//       refresh: json['refresh'],
//       access: json['access'],
//       role: json['role'],
//       userId: json['userid'],
//       email: json['email'],
//       gender: json['gender'],
//       pincode: json['pincode'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       phoneNo: json['phone_no'],
//       address: json['address'],
//       state: json['state'],
//       city: json['city'],
//       profile: json['profile'],
//       isActive: json['isactive'],
//       myReferal: json['my_referal'],
//       byReferal: json['by_referal'],
//       registrationDate: json['registration_date'],
//       dateOfBirth: json['date_of_birth'],
//     );
//   }
// }

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final access = (json['token'] ?? json['accessToken'] ?? '').toString();
    final refresh = (json['refreshToken'] ?? '').toString();

    return UserModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse('${json['id']}') ?? 0,
      username: '${json['username'] ?? ''}',
      email: '${json['email'] ?? ''}',
      accessToken: access,
      refreshToken: refresh,
    );
  }
}
