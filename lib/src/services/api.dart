class API {
  static String stageHost = 'oromo-dictionary-stage.herokuapp.com';
  static String productionHost = 'oromo-dictionary.herokuapp.com';
  static String localhost = "10.0.2.2";

  static Uri searchURL = Uri(scheme: 'https', host: stageHost);
}
