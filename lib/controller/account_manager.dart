class AccountManager {
  factory AccountManager() {
    return _singleton;
  }

  AccountManager._internal();

  static final AccountManager _singleton = AccountManager._internal();
}
