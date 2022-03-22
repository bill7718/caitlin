

import 'dart:async';

import 'authentication_service.dart';

class MockAuthenticationService implements AuthenticationService {

  @override
  String? uid;
  @override
  String? email;



  @override
  Future<String?> createUser(String email, String password) async {
    var c = Completer<String>();
    uid = '${email}_uid';
    this.email = email;
    c.complete('${email}_uid');
    return c.future;
  }

  @override
  Future<String?> authenticate(String email, String password) async {
    var c = Completer<String?>();

    if (password == 'badpassword') {
      c.complete();
    } else {
      uid = '${email}_uid';
      this.email = email;
      c.complete('${email}_uid');
    }

    return c.future;
  }



  @override
  bool get authenticated => uid!= null;

  @override
  Future<void> logout() {
    var c = Completer<void>();
    email= null;
    uid = null;
    c.complete();
    return c.future;
  }
}