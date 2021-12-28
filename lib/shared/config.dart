class Config {
  static const String apiUrl = 'http://173.212.193.40:5486/';
  static int selectedIndexGNB = 0;
  static const int cantNewMarket = 10;

  static Map<String, bool> categories = {
    'Symbol': false,
    'Country': false,
    'Industry': false,
    'Ipo Year': false,
    'Market Cap': false,
    'Sector': false,
    'Volume': false,
    'Net Change': false,
    'Net Change Percent': false,
    'Last Price': false,
    'Created At': false,
    'Updated At': false,
    'Id': false,
  };
}
