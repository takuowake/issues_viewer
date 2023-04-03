import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/issue.dart';
import 'repositories/github_api.dart';
import 'repositories/github_repository.dart';
import 'repositories/issues_repository.dart';

final issuesRepositoryProvider = Provider((ref) => IssuesRepository(githubRepository: GithubRepository(api: GithubApi())));

void main() {
  runApp(ProviderScope(child: MyApp()));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final issuesRepositoryProvider =
  Provider((ref) => IssuesRepository(githubRepository: GithubRepository(api: GithubApi())));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Issues Viewer',
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Issues Viewer'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'すべて'),
                Tab(text: 'p: webview'),
                Tab(text: 'p: shared_preferences'),
                Tab(text: 'waiting for customer response'),
                Tab(text: 'severe: new feature'),
                Tab(text: 'p: share'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildTabView(context, IssueState.all),
              _buildTabView(context, IssueState.pWebView),
              _buildTabView(context, IssueState.pSharedPreferences),
              _buildTabView(context, IssueState.waitingForCustomerResponse),
              _buildTabView(context, IssueState.severeNewFeature),
              _buildTabView(context, IssueState.pShare),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabView(BuildContext context, IssueState issueState) {
    final issuesRepository = ProviderContainer().read(issuesRepositoryProvider);
    return FutureBuilder<List<Issue>>(
      future: issuesRepository.getIssues(issueState),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final issues = snapshot.data;
          return ListView.builder(
            itemCount: issues!.length,
            itemBuilder: (context, index) {
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

        return Container();
      },
    );
  }
}