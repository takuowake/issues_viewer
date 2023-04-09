import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/issue.dart';

final githubApiProvider = Provider((ref) => GithubApi());

///Github APIの呼び出し
class GithubApi {
  static const String _baseUrl = 'https://api.github.com';
  static const String _repository = 'flutter/flutter';
  final String githubAccessToken = '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';
  int perPage = 10;

  ///全てのIssuesを取得
  Future<List<Issue>> fetchAllIssues(int page) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/repos/$_repository/issues?&per_page=$perPage&state=all&page=$page'),
      headers: {
        'Authorization': 'token $githubAccessToken',
        'Accept': 'application/vnd.github.v3+json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Issue.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load issues: ${response.reasonPhrase}');
    }
  }

  ///特定のラベルを持つIssuesを取得
  Future<List<Issue>> fetchIssuesByLabel(String label, int page) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/flutter/flutter/issues?labels=$label&per_page=$perPage&state=all&page=$page'),
      headers: {
        'Authorization': 'token $githubAccessToken',
        'Accept': 'application/vnd.github.v3+json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data == null) {
        return [];
      }
      return data.map((json) => Issue.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load issues: ${response.reasonPhrase}');
    }
  }
}

// final githubApiProvider = Provider((ref) => GithubApi());
//
// ///Github APIの呼び出し
// class GithubApi {
//   static const String _baseUrl = 'https://api.github.com';
//   static const String _repository = 'flutter/flutter';
//   final String githubAccessToken = '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';
//
//   ///ページ単位でIssuesを取得
//   Future<List<Issue>> fetchIssues(int page) async {
//     final response = await http.get(
//       Uri.parse('$_baseUrl/repos/$_repository/issues?&per_page=10&state=all'),
//       // Uri.parse('$_baseUrl/repos/$_repository/issues?&per_page=100&page=$page&state=all'),
//       headers: {
//         'Authorization': 'token $githubAccessToken',
//         'Accept': 'application/vnd.github.v3+json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Issue.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load issues: ${response.reasonPhrase}');
//     }
//   }
//
//   ///全てのIssuesを取得
//   Future<List<Issue>> fetchAllIssues() async {
//     List<Issue> allIssues = [];
//     int page = 1;
//
//     while (true) {
//       final List<Issue> issues = await fetchIssues(page);
//       if (issues.isEmpty) {
//         break;
//       }
//       allIssues.addAll(issues);
//       page++;
//     }
//
//     return allIssues;
//   }
// }