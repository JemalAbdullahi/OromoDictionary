class API {
  static String stageHost = 'oromo-dictionary-staging.herokuapp.com';
  static String productionHost = 'oromo-dictionary.herokuapp.com';
  static String localhost = "10.0.2.2";

  static Uri searchURL = Uri(scheme: 'http', host: localhost, port: 5000);
  //static Uri searchURL = Uri(scheme: 'https', host: stagehost);

  static String language = "en";

  static bool isEnglish() {
    return language == "en";
  }

  static bool isOromo() {
    return language == "om";
  }
}
