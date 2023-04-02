import 'package:flutter/material.dart';

import 'models/issue.dart';
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
  List<Issue> allFlutterIssues = [];

  int _currentPage = 1;
  int _perPage = 10;
  bool _isLoading = false;
  bool _isLastPage = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchAllFlutterIssues();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _fetchAllFlutterIssues() async {
    setState(() {
      _isLoading = true;
    });
    final response = await githubApi.getFlutterIssues(_currentPage, _perPage);
    setState(() {
      allFlutterIssues.addAll(response);
      _isLoading = false;
      if(response.length < _perPage) {
        _isLastPage = true;
      }
    });
  }

  void _scrollListener() {
    if(_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      if(!_isLoading && !_isLastPage) {
        setState(() {
          _currentPage ++;
          _isLoading = true;
        });
        _fetchAllFlutterIssues();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Issues'),
        ),
        body: Center(
          child: allFlutterIssues.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
            controller: _scrollController,
            itemCount: allFlutterIssues.length,
            itemBuilder: (BuildContext context, int index) {
              final issue = allFlutterIssues[index];
              return issue != null ? ListTile(
                title: Text(issue.title),
                subtitle: Text(
                  '#${issue.id} opened by ${issue.title}',
                ),
              ):Container();
            },
          ),
        ),
      ),
    );
  }
}