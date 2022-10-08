import 'package:dttv/import.dart';

enum SessionState { init, loggedIn, loggedOut, expired }

class SessionManager {
  factory SessionManager() {
    return _singleton;
  }

  SessionManager._internal() {
    onInit();
  }

  static final SessionManager _singleton = SessionManager._internal();

  void onInit() {
    _state.listen((SessionState state) {
      switch (state) {
        case SessionState.init:
          break;
        case SessionState.loggedIn:
          break;
        case SessionState.expired:
        case SessionState.loggedOut:
          break;
      }
    });
  }

  //
  final Rx<SessionState> _state = SessionState.init.obs;
  Rx<SessionState> get state => _state;
  set setState(SessionState value) => _state.value = value;

  bool get hasSession => _state.value == SessionState.loggedIn;

  String get accessToken => '';
}
