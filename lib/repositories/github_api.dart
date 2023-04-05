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

  ///全てのIssuesを取得
  Future<List<Issue>> fetchIssues() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/repos/$_repository/issues?&per_page=100'),
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
  Future<List<Issue>> fetchIssuesByLabel(String label) async {
    final response = await http.get(
      // Uri.parse('$_baseUrl/repos/$_repository/issues?state=all&labels=p%3A+webview&per_page=100'),
      Uri.parse('https://api.github.com/repos/flutter/flutter/issues?labels=$label'),
      // Uri.parse('https://github.com/flutter/flutter/issues?q=label%3A%22new+feature%22'),
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