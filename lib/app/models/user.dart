class User {
  String? id;
  String? name;
  String? job;
  String? location;
  String? marriage;
  String? gender;
  String? age;
  String? avatar;
  String? photos;

  User({
    this.id,
    this.name,
    this.job,
    this.location,
    this.marriage,
    this.gender,
    this.age,
    this.avatar,
    this.photos,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    job = json['job'];
    location = json['location'];
    marriage = json['marriage'];
    gender = json['gender'];
    age = json['age'];
    avatar = json['avatar'];
    photos = json['photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['job'] = job;
    data['location'] = location;
    data['marriage'] = marriage;
    data['gender'] = gender;
    data['age'] = age;
    data['avatar'] = avatar;
    data['photos'] = photos;
    return data;
  }
}
