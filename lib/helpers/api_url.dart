class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id';

  static const String registrasi = 'http://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'http://responsi.webwizards.my.id/api/login';
  static const String listKeuangan = baseUrl + '/keuangan/investasi/';
  static const String createKeuangan = baseUrl + '/keuangan/investasi/';

  static String updateKeuangan(int id) {
    return baseUrl + '/keuangan/investasi/' + id.toString(); // sesuaikan dengan url API yang sudah dibuat
  }

  static String showKeuangan(int id) {
    return baseUrl + '/keuangan/investasi/' + id.toString(); // sesuaikan dengan url API yang sudah dibuat
  }

  static String deleteKeuangan(int id) {
    return baseUrl + '/keuangan/investasi/' + id.toString(); // sesuaikan dengan url API yang sudah dibuat
  }
}
