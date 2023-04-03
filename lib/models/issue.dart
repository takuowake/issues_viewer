class Issue {
  final String title;
  final int number;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String body;
  final int id; // 追加
  final List<String> labels; // 追加

  Issue({
    required this.title,
    required this.number,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.body,
    required this.id, // 追加
    required this.labels, // 追加
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      title: json['title'],
      number: json['number'],
      state: json['state'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      body: json['body'],
      id: json['id'], // 追加
      labels: List<String>.from(json['labels'].map((label) => label['name'])), // 追加
    );
  }
}

class User {
  final String login;
  final String avatarUrl;

  User({
    required this.login,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
    );
  }
}

enum IssueState {
  all,
  pWebView,
  pSharedPreferences,
  waitingForCustomerResponse,
  severeNewFeature,
  pShare,
}