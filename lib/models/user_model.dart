import 'package:flyerdeal/infrastructure/request.dart';
import 'package:flyerdeal/infrastructure/utils.dart';
import 'package:flyerdeal/models/address.dart';
import 'package:flyerdeal/infrastructure/request.dart';

class UserModel extends RentXSerialized {
  String? email;
  String? name;
  String? username;
  String? surname;
  DateTime? birthdate;
  UserRole? role;
  Address? address;
  String? password;
  String? confirmPassword;
  String? personalId;
  String? phoneNumber;
  String? profilePictureId;

  UserModel.instance();

  UserModel(
      {this.email,
      this.name,
      this.username,
      this.surname,
      this.birthdate,
      this.role,
      this.address,
      this.password,
      this.confirmPassword,
      this.personalId,
      this.phoneNumber,

      this.profilePictureId});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['firstName'];
    surname = json['lastName'];
    birthdate = json['birthDate'].toDate();
    confirmPassword = json['confirmPassword'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    role = EnumUtil.strToEnum(UserRole.values, json['role']);
    password = json['password'];
    personalId = json['personalId'];
    profilePictureId = json['profilePictureId'];

  }

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': name,
        'lastName': surname,
        'username': username,
        'birthDate': birthdate ?? birthdate?.toIso8601String(),
        'role': role?.name,
        'address': address == null ? null : address!.toJson(),
        'password': password,
        'confirmPassword': confirmPassword,
        'personalId': personalId,
        'phoneNumber': phoneNumber,
        'profilePictureId': profilePictureId,
      };

  String getFullName() => '$name $surname';
}

enum UserRole { client, tech, admin }

enum Gender { male, female,}
