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
    UserModel? local = await fetchFromLocal();
    UserModel? remote = await fetchFromRemote();
    if (remote == null) {
      return local;
    }

    await localDataSource.saveUser(remote);
    return remote;
  }

  @override
  Future<UserModel?> fetchFromLocal() {
    return localDataSource.fetchUser();
  }

  @override
  Future<UserModel?> fetchFromRemote() {
    return fetchFromRemote();
  }
}