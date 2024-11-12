import 'package:youapp/domain/repositories/token_repository.dart';

class TokenUseCase {
  final TokenRepository repository;

  TokenUseCase(this.repository);

  Future<String?> fetch() {
    return repository.fetch();
  }

  Future<void> store(String token) async {
    await repository.store(token);
  }
}
