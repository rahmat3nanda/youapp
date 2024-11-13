class UserModel {
  final String? email;
  final String? username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  List<String>? interests;

  UserModel({
    this.email,
    this.username,
    this.name,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
    this.interests,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        username: json["username"],
        name: json["name"],
        birthday: json["birthday"],
        horoscope: json["horoscope"],
        zodiac: json["zodiac"],
        height: json["height"],
        weight: json["weight"],
        interests: json["interests"] == null
            ? null
            : List<String>.from(json["interests"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "name": name,
        "birthday": birthday,
        "horoscope": horoscope,
        "zodiac": zodiac,
        "height": height,
        "weight": weight,
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests!.map((x) => x)),
      };
}
