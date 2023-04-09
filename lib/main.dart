import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/issue.dart';
import 'repositories/github_api.dart';
import 'repositories/github_repository.dart';
import 'repositories/issues_repository.dart';
import 'package:http/http.dart' as http;

// // final issuesRepositoryProvider =
// // Provider((ref) => IssuesRepository(githubRepository: GithubRepository(api: GithubApi())));
// final githubRepositoryProvider =
// Provider((ref) => GithubRepository(api: GithubApi()));
//
// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   // late final IssuesRepository issuesRepository;
//   late final GithubRepository githubRepository;
//   int _currentIndex = 0;
//   int _page = 1;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // issuesRepository = IssuesRepository(githubRepository: GithubRepository(api: GithubApi()));
//     githubRepository = GithubRepository(api: GithubApi());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Issues Viewer',
//       home: DefaultTabController(
//         length: 6,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Flutter Issues Viewer'),
//               ],
//             ),
//             bottom: TabBar(
//               tabs: [
//                 Tab(text: 'すべて'),
//                 Tab(text: 'p:webview'),
//                 Tab(text: 'p: shared_preferences'),
//                 Tab(text: 'waiting for customer response'),
//                 Tab(text: 'new feature'),
//                 Tab(text: 'p: share'),
//               ],
//               onTap: (index) {
//                 setState(() {
//                   _currentIndex = index;
//                 });
//               },
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               _buildTabView(context, IssueLabel.all),
//               _buildTabView(context, IssueLabel.pWebView),
//               _buildTabView(context, IssueLabel.pSharedPreferences),
//               _buildTabView(context, IssueLabel.waitingForCustomerResponse),
//               _buildTabView(context, IssueLabel.newFeature),
//               _buildTabView(context, IssueLabel.pShare),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTabView(BuildContext context, IssueLabel issueLabel) {
//     List<Issue> _issues = [];
//     // 以下の行を追加
//     return FutureBuilder<List<Issue>>(
//       // future: issuesRepository.getIssues(issueLabel, page: _page),
//       future: githubRepository.getIssues(issueLabel, page: _page),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting && !_isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasData) {
//           final issues = snapshot.data;
//           _issues.addAll(issues!);
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: (issues?.length ?? 0) + 1,
//             itemBuilder: (context, index) {
//               if (index == issues?.length && _isLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (index == issues?.length) {
//                 return ElevatedButton(
//                   onPressed: () async {
//                     setState(() {
//                       _isLoading = true;
//                       _page++;
//                     });
//                     // final newIssues = await issuesRepository.getIssues(issueLabel, page: _page);
//                     final newIssues = await githubRepository.getIssues(issueLabel, page: _page);
//                     setState(() {
//                       _isLoading = false;
//                       issues?.addAll(newIssues);
//                     });
//                   },
//                   child: const Text('次へ'),
//                 );
//               }
//               if (index == issues?.length && _isLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               final issue = issues![index];
//               return ListTile(
//                 title: Text(issue.title),
//                 subtitle: Text('#${issue.number} opened by ${issue.labels}'),
//               );
//             },
//           );
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Failed to load issues: ${snapshot.error}'));
//         }
//         return Container(
//           child: Center(
//             child: Text(
//               'No data',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

final githubRepositoryProvider =
Provider((ref) => GithubRepository(api: GithubApi()));

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GithubRepository githubRepository;
  List<List<Issue>> _issuesList = [
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  int _currentIndex = 0;
  int _page = 1;
  List<bool> _isLoadingList = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    githubRepository = GithubRepository(api: GithubApi());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Issues Viewer',
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Flutter Issues Viewer'),
              ],
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: 'すべて'),
                Tab(text: 'p:webview'),
                Tab(text: 'p: shared_preferences'),
                Tab(text: 'waiting for customer response'),
                Tab(text: 'new feature'),
                Tab(text: 'p: share'),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          body: TabBarView(
            children: [
              _buildTabView(context, IssueLabel.all, 0),
              _buildTabView(context, IssueLabel.pWebView, 1),
              _buildTabView(context, IssueLabel.pSharedPreferences, 2),
              _buildTabView(context, IssueLabel.waitingForCustomerResponse, 3),
              _buildTabView(context, IssueLabel.newFeature, 4),
              _buildTabView(context, IssueLabel.pShare, 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabView(BuildContext context, IssueLabel issueLabel, int index) {
    // 以下の行を変更
    List<Issue> _issues = _issuesList[index];
    bool _isLoading = _isLoadingList[index];
    return FutureBuilder<List<Issue>>(
      future: githubRepository.getIssues(issueLabel, page: _page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final issues = snapshot.data;
          _issues.addAll(issues!);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: (issues?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (index == issues?.length && _isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (index == issues?.length) {
                return ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoadingList[_currentIndex] = true;
                      _page++;
                    });
                    final newIssues = await githubRepository.getIssues(issueLabel, page: _page);
                    setState(() {
                      _isLoadingList[_currentIndex] = false;
                      issues?.addAll(newIssues);
                    });
                  },
                  child: const Text('次へ'),
                );
              }
              if (index == issues?.length && _isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              final issue = issues![index];
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
        return Container(
          child: Center(
            child: Text(
              'No data',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}