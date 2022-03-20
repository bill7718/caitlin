

import 'dart:async';

import 'authentication_service.dart';

class MockAuthenticationService implements AuthenticationService {


  @override
  Future<String?> createUser(String email, String password) async {
    var c = Completer<String>();
    c.complete('${email}_uid');
    return c.future;
  }

  @override
  Future<String?> authenticate(String email, String password) async {
    var c = Completer<String?>();

    if (password == 'badpassword') {
      c.complete();
    } else {
      c.complete('${email}_uid');
    }

    return c.future;
  }
}