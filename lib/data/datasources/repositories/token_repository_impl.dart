import 'package:youapp/data/datasources/local/token_local_data_source.dart';
import 'package:youapp/domain/repositories/token_repository.dart';

class TokenRepositoryImpl extends TokenRepository {
  final TokenLocalDataSource localDataSource;

  TokenRepositoryImpl({required this.localDataSource});

  @override
  Future<String?> fetch() {
    return localDataSource.fetch();
  }

  @override
  Future<void> store(String token) async {
    await localDataSource.store(token);
  }

  @override
  Future<void> remove() async {
    await localDataSource.remove();
  }
}
