class Label {
  final String name;

  Label({required this.name});

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(name: json['name']);
  }
}