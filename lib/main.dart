import 'package:flutter/material.dart';
import 'package:youapp/app.dart';
import 'package:youapp/app/configs/app_config.dart';
import 'package:youapp/app/constants/app_log.dart';
import 'package:youapp/data/models/app/app_version_model.dart';
import 'package:youapp/data/models/app/scheme_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppLog.debugMode = true;
  AppConfig.shared.initialize(
    scheme: AppScheme.prod,
    baseUrlApi: "https://techtest.youapp.ai/api/",
    version: AppVersionModel.empty(),
  );
  runApp(const App());
}
