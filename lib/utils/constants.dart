bool labelContains(String label, String query) {
  return label.toLowerCase().contains(query.toLowerCase());
}

class Constants {
  static const String allLabel = 'All';
  static const String pWebView = 'Priority: WebView';
  static const String pSharedPreferences = 'Priority: SharedPreferences';
  static const String waitingForCustomerResponse = 'Waiting for Customer Response';
  static const String severeNewFeature = 'Severe/New Feature';
  static const String pShare = 'Priority: Share';

  static const String apiUrl = 'https://api.github.com';
}