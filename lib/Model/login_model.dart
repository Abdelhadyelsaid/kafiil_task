class LoginModel {
  LoginModel({
    required this.status,
    required this.success,
    required this.data,
    required this.accessToken,
  });
  late final int status;
  late final bool success;
  late final Data data;
  late final String accessToken;

  LoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    success = json['success'];
    data = Data.fromJson(json['data']);
    accessToken = json['access_token'];
  }
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.about,
    required this.favoriteSocialMedia,
    required this.salary,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.type,
    required this.avatar,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String about;
  late final List<String> favoriteSocialMedia;
  late final int salary;
  late final String email;
  late final String birthDate;
  late final int gender;
  late final Type type;
  late final String avatar;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    about = json['about'];
    favoriteSocialMedia = List.castFrom<dynamic, String>(json['favorite_social_media']);
    salary = json['salary'];
    email = json['email'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    type = Type.fromJson(json['type']);
    avatar = json['avatar'];
  }
}


class Type {
  Type({
    required this.code,
    required this.name,
    required this.niceName,
  });
  late final int code;
  late final String name;
  late final String niceName;

  Type.fromJson(Map<String, dynamic> json){
    code = json['code'];
    name = json['name'];
    niceName = json['nice_name'];
  }
}