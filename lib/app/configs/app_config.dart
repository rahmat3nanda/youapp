import 'package:youapp/data/models/app/app_version_model.dart';
import 'package:youapp/data/models/app/scheme_model.dart';

class AppConfig {
  static AppConfig? _config;

  factory AppConfig() => _config ??= AppConfig._internal();

  AppConfig._internal();

  static AppConfig get shared => _config ??= AppConfig._internal();

  late AppScheme scheme;
  late String baseUrlApi;
  late AppVersionModel version;

  void initialize({
    required AppScheme scheme,
    required String baseUrlApi,
    required AppVersionModel version,
  }) {
    this.scheme = scheme;
    this.baseUrlApi = baseUrlApi;
    this.version = version;
  }
}
