// class Login {
//   final int code;
//   final String message;
//   final String refresh;
//   final String access;
//   final String role;
//   final int userId;
//   final String? email;
//   final String? gender;
//   final String? pincode;
//   final String? firstName;
//   final String? lastName;
//   final String phoneNo;
//   final String? address;
//   final String? state;
//   final String? city;
//   final String? profile;
//   final bool isActive;
//   final String myReferal;
//   final String? byReferal;
//   final String registrationDate;
//   final String? dateOfBirth;

//   Login({
//     required this.code,
//     required this.message,
//     required this.refresh,
//     required this.access,
//     required this.role,
//     required this.userId,
//     this.email,
//     this.gender,
//     this.pincode,
//     this.firstName,
//     this.lastName,
//     required this.phoneNo,
//     this.address,
//     this.state,
//     this.city,
//     this.profile,
//     required this.isActive,
//     required this.myReferal,
//     this.byReferal,
//     required this.registrationDate,
//     this.dateOfBirth,
//   });

//   factory Login.fromJson(Map<String, dynamic> json) {
//     return Login(
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

//   Map<String, dynamic> toJson() {
//     return {
//       'code': code,
//       'message': message,
//       'refresh': refresh,
//       'access': access,
//       'role': role,
//       'userid': userId,
//       'email': email,
//       'gender': gender,
//       'pincode': pincode,
//       'first_name': firstName,
//       'last_name': lastName,
//       'phone_no': phoneNo,
//       'address': address,
//       'state': state,
//       'city': city,
//       'profile': profile,
//       'isactive': isActive,
//       'my_referal': myReferal,
//       'by_referal': byReferal,
//       'registration_date': registrationDate,
//       'date_of_birth': dateOfBirth,
//     };
//   }
// }

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String accessToken;
  final String refreshToken;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [id, username, email, accessToken, refreshToken];
}
