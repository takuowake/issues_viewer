import 'package:flutter/material.dart';

import '../models/issue.dart';
import '../repositories/github_repository.dart';

class IssueList extends StatefulWidget {
  const IssueList({Key? key, required this.issueLabel}) : super(key: key);

  final IssueLabel issueLabel;

  @override
  _IssueListState createState() => _IssueListState();
}

class _IssueListState extends State<IssueList> {
  late final GithubRepository githubRepository;
  int _page = 1;
  bool _isLoading = false;
  final List<Issue> _issues = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Issue>>(
      future: githubRepository.getIssues(widget.issueLabel, page: _page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final issues = snapshot.data;
          _issues.addAll(issues!);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: (issues.length) + 1,
            itemBuilder: (context, index) {
              if (index == issues.length && _isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (index == issues.length) {
                return ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                      _page++;
                    });
                    final newIssues = await githubRepository.getIssues(widget.issueLabel, page: _page);
                    setState(() {
                      _isLoading = false;
                      _issues.addAll(newIssues);
                    });
                  },
                  child: const Text('次へ'),
                );
              }
              final issue = issues[index];
              return ListTile(
                title: Text(issue.title),
                subtitle: Text('#${issue.number} opened by ${issue.labels}'),
              );
            },
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text('Failed to load issues: ${snapshot.error}'));
        }
        return const Center(
          child: Text(
            'No data',
            style: TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }
}