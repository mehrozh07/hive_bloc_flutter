import 'package:hive/hive.dart';
part 'user_model.g.dart';


@HiveType(typeId: 0)
class UserModel extends HiveObject {

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? bio;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? gender;

  @HiveField(5)
  String? dob;

  UserModel({required this.id,
    required this.title,required this.bio,
    required this.email,
    required this.gender,
    required this.dob});
}