import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/issue.dart';
import '../repositories/github_api.dart';
import '../repositories/github_repository.dart';
import 'issue_list.dart';

final githubRepositoryProvider = Provider((ref) => GithubRepository(api: GithubApi()));

class IssueViewer extends StatefulWidget {
  const IssueViewer({Key? key}) : super(key: key);

  @override
  _IssueViewerState createState() => _IssueViewerState();
}

class _IssueViewerState extends State<IssueViewer> {
  late final GithubRepository githubRepository;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Issues Viewer',
      home: DefaultTabController(
        initialIndex: 0,
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Flutter Issues Viewer'),
              ],
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'すべて'),
                Tab(text: 'p:webview'),
                Tab(text: 'p: shared_preferences'),
                Tab(text: 'waiting for customer response'),
                Tab(text: 'new feature'),
                Tab(text: 'p: share'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              IssueList(issueLabel: IssueLabel.all),
              IssueList(issueLabel: IssueLabel.pWebView),
              IssueList(issueLabel: IssueLabel.pSharedPreferences),
              IssueList(issueLabel: IssueLabel.waitingForCustomerResponse),
              IssueList(issueLabel: IssueLabel.newFeature),
              IssueList(issueLabel: IssueLabel.pShare),
            ],
          ),
        ),
      ),
    );
  }
}