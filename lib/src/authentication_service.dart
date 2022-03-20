
abstract class AuthenticationService {
  Future<String?> createUser(String email, String password);

  Future<String?> authenticate(String email, String password);
}

class AuthenticationException implements Exception {
  final String _message;

  AuthenticationException(this._message);

  @override
  String toString()=>_message;
}