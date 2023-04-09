class Issue {
  final String title;
  final int number;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String body;
  final int id;
  final htmlUrl;
  final List<String> labels;

  Issue({
    required this.title,
    required this.number,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.body,
    required this.id,
    required this.labels,
    required this.htmlUrl,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      title: json['title'],
      number: json['number'],
      state: json['state'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      body: json['body'],
      id: json['id'],
      htmlUrl: json['html_url'],
      labels: List<String>.from(json['labels'].map((label) => label['name'])),
    );
  }
}

enum IssueLabel {
  all,
  pWebView,
  pSharedPreferences,
  waitingForCustomerResponse,
  newFeature,
  pShare
}