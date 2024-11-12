class AppVersionModel {
  late String name;
  late int number;

  AppVersionModel({required this.name, required this.number});

  factory AppVersionModel.empty() => AppVersionModel(name: "1.0.0", number: 1);

  @override
  String toString() => "$name($number)";
}
