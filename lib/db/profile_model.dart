import 'package:hive/hive.dart';

part 'profile_model.g.dart'; // Include this line

@HiveType(typeId: 0)
class ProfileModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String domain;

  @HiveField(2)
  String batchNo;

  @HiveField(3)
  String email;

  @HiveField(4)
  String phoneNumber;

  ProfileModel({
    required this.name,
    required this.domain,
    required this.batchNo,
    required this.email,
    required this.phoneNumber,
  });
}
