import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:youapp/app/bindings/initial_binding.dart';
import 'package:youapp/app/configs/app_config.dart';
import 'package:youapp/app/configs/app_locale.dart';
import 'package:youapp/app/constants/app_string.dart';
import 'package:youapp/app/routes/app_pages.dart';
import 'package:youapp/app/styles/app_theme.dart';
import 'package:youapp/data/models/app/app_version_model.dart';
import 'package:youapp/data/models/app/scheme_model.dart';
import 'package:youapp/presentation/pages/splash_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  void _getInfo() async {
    PackageInfo.fromPlatform().then((i) {
      setState(() {
        AppConfig.shared.version = AppVersionModel(
          name: i.version,
          number: int.tryParse(i.buildNumber) ?? 1,
        );
      });
    }).catchError((e) {
      _getInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GetMaterialApp(
              initialBinding: InitialBinding(),
              getPages: AppPages.routes,
              localizationsDelegates: AppLocale.delegates,
              supportedLocales: AppLocale.supports,
              debugShowCheckedModeBanner: false,
              title: AppString.appName,
              theme: AppTheme.main(context),
              home: const SplashPage(),
            ),
          ),
          if (AppConfig.shared.scheme == AppScheme.dev)
            IgnorePointer(
              ignoring: true,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Opacity(
                  opacity: .3,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: double.infinity),
                      Text(
                        "DEV\n${AppConfig.shared.version.toString()}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 32.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
