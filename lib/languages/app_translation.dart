class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    "en": Locales.en,
    "vi": Locales.vi,
  };
}

class LocaleKeys {
  LocaleKeys._();
  static const login = "login";
}

class Locales {
  //ENG:
  static const en = {
    "login": "Login",
  };

  //VI:
  static const vi = {
    "login": "Đăng nhập"
  };
}
