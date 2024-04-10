class AppLanguage {
  static final AppLanguage _singleton = AppLanguage._internal();
  factory AppLanguage() {
    return _singleton;
  }
  AppLanguage._internal();

  String currentLanguage = "en-US";
}
