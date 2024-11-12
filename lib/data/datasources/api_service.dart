abstract class ApiService {
  Future post({
    required String url,
    dynamic body,
    Map<String, dynamic>? param,
  });

  Future patch({
    required String url,
    required dynamic body,
    Map<String, dynamic>? param,
  });

  Future get({
    required String url,
    Map<String, dynamic>? param,
  });

  Future delete({
    required String url,
    dynamic body,
    Map<String, dynamic>? param,
  });
}
