abstract class TokenRepository {
  Future<String?> fetch();

  Future<void> store(String token);

  Future<void> remove();
}
