import 'package:youapp/data/datasources/local/user_local_data_source.dart';
import 'package:youapp/data/datasources/remote/user_remote_data_source.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<UserModel?> fetch() async {
    try {
      UserModel? local = await fetchFromLocal();
      UserModel? remote = await fetchFromRemote();
      if (remote == null) {
        return local;
      }

      return remote;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> fetchFromLocal() {
    return localDataSource.fetchUser();
  }

  @override
  Future<UserModel?> fetchFromRemote() async {
    try {
      UserModel data = await remoteDataSource.fetchUser();
      await localDataSource.saveUser(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> destroy() async {
    await localDataSource.destroy();
  }
}
