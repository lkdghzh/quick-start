import 'package:get/get.dart';

class UserState {
  // 用户基本信息
  final _name = "".obs;
  final _avatar = "".obs;
  final _age = "".obs;
  final _gender = "".obs;
  final _location = "".obs;
  final _job = "".obs;
  final _marriage = "".obs;

  // 用户详细信息
  final _bio = "".obs;
  final _interests = <String>[].obs;
  final _photos = <String>[].obs;

  // getter 和 setter
  String get name => _name.value;
  set name(String value) => _name.value = value;

  String get avatar => _avatar.value;
  set avatar(String value) => _avatar.value = value;

  String get age => _age.value;
  set age(String value) => _age.value = value;

  String get gender => _gender.value;
  set gender(String value) => _gender.value = value;

  String get location => _location.value;
  set location(String value) => _location.value = value;

  String get job => _job.value;
  set job(String value) => _job.value = value;

  String get marriage => _marriage.value;
  set marriage(String value) => _marriage.value = value;

  String get bio => _bio.value;
  set bio(String value) => _bio.value = value;

  List<String> get interests => _interests;
  set interests(List<String> value) => _interests.value = value;

  List<String> get photos => _photos;
  set photos(List<String> value) => _photos.value = value;
}
