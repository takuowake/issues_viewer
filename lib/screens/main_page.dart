import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../utils/enums/issue_state.dart';
import '../repositories/issues_repository.dart';
import '../models/issue.dart';

class MainPage extends StatefulWidget {
  final IssuesRepository issuesRepository;

  MainPage({required this.issuesRepository});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  IssueState _currentIssueState = IssueState.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Issues'),
      ),
      body: FutureBuilder<List<Issue>>(
        future: widget.issuesRepository.getIssues(_currentIssueState),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildIssuesList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIssueState.index,
        items: _buildBottomNavigationBarItems(),
        onTap: (index) {
          setState(() {
            _currentIssueState = IssueState.values[index];
          });
        },
      ),
    );
  }

  Widget _buildIssuesList(List<Issue> issues) {
    return ListView.builder(
      itemCount: issues.length,
      itemBuilder: (context, index) {
        final issue = issues[index];
        return ListTile(
          title: Text(issue.title),
          subtitle: Text('#${issue.number} opened by ${issue.user.login}'),
          trailing: issue.state == 'open' ? Icon(Icons.warning) : Icon(Icons.check),
          onTap: () {
            // TODO: Implement issue detail page
          },
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.all_inbox),
        label: 'All',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.web),
        label: 'p: webview',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.storage),
        label: 'p: shared_preferences',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'Waiting for Customer',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.new_releases),
        label: 'Severe New Feature',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.share),
        label: 'p: share',
      ),
    ];
  }
}