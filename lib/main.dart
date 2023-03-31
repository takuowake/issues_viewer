import 'package:flutter/material.dart';
import 'package:issues_viewer/repositories/github_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GithubApi githubApi = GithubApi();
  List<dynamic> githubRepos = [];

  @override
  void initState() {
    super.initState();
    _fetchGithubRepos();
  }

  Future<void> _fetchGithubRepos() async {
    final response = await githubApi.get('https://api.github.com/user/repos');
    setState(() {
      githubRepos = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: githubRepos.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
            itemCount: githubRepos.length,
            itemBuilder: (BuildContext context, int index) {
              final repo = githubRepos[index];
              return ListTile(
                title: Text(repo['name']),
                subtitle: Text(repo['description'] ?? 'No description'),
              );
            },
          ),
        ),
      ),
    );
  }
}