import 'package:flutter/material.dart';

import 'repositories/github_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GithubApi githubApi = GithubApi();
  List<dynamic> flutterIssues = [];

  @override
  void initState() {
    super.initState();
    _fetchFlutterIssues();
  }

  Future<void> _fetchFlutterIssues() async {
    final response = await githubApi.getFlutterIssues();
    setState(() {
      flutterIssues = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Issues'),
        ),
        body: Center(
          child: flutterIssues.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
            itemCount: flutterIssues.length,
            itemBuilder: (BuildContext context, int index) {
              final issue = flutterIssues[index];
              return ListTile(
                title: Text(issue['title']),
                subtitle: Text(
                  '#${issue['number']} opened by ${issue['user']['login']}',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}