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

// class User {
//   final String login;
//   final String avatarUrl;
//
//   User({
//     required this.login,
//     required this.avatarUrl,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       login: json['login'] as String,
//       avatarUrl: json['avatar_url'] as String,
//     );
//   }
// }

enum IssueLabel {
  all,
  pWebView,
  pSharedPreferences,
  waitingForCustomerResponse,
  newFeature,
  pShare
}

extension IssueLabelExtension on IssueLabel {
  String get label {
    switch (this) {
      case IssueLabel.all:
        return '';
      case IssueLabel.pWebView:
        return 'p:webview';
      case IssueLabel.pSharedPreferences:
        return 'p:shared_preferences';
      case IssueLabel.waitingForCustomerResponse:
        return 'waiting%20for%20customer%20response';
      case IssueLabel.newFeature:
        return 'new%20feature';
      case IssueLabel.pShare:
        return 'p:share';
    }
  }
}