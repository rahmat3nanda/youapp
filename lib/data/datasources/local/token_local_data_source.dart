import 'package:youapp/data/datasources/sp_data.dart';

class TokenLocalDataSource {
  Future<String?> fetch() {
    return SPData.load<String>("token");
  }

  Future<void> store(String token) async {
    await SPData.save<String>("token", token);
  }

  Future<void> remove() async {
    await SPData.remove("token");
  }
}
