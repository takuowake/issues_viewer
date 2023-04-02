class Issue {
  int id;
  String title;
  String body;
  String state;
  String author;
  String createdAt;
  String updatedAt;
  List<String> labels;

  Issue({
    required this.id,
    required this.title,
    required this.body,
    required this.state,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
    required this.labels,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      state: json['state'],
      author: json['user']['login'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      labels: List<String>.from(
          json['labels'].map((label) => label['name']).toList()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'state': state,
      'author': author,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'labels': labels,
    };
  }
}