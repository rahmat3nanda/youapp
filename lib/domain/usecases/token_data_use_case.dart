import 'package:youapp/domain/repositories/token_repository.dart';

class TokenDataUseCase {
  final TokenRepository repository;

  TokenDataUseCase(this.repository);

  Future<String?> fetch() {
    return repository.fetch();
  }

  Future<void> store(String token) async {
    await repository.store(token);
  }
}
