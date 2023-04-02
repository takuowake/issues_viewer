import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/issue.dart';

class GithubApi {
  static const String _baseUrl = 'https://api.github.com';
  static const String _repository = 'flutter/flutter';
  final String githubAccessToken = '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';


  Future<List<Issue>> fetchIssues() async {
    final response = await http.get(
      '$_baseUrl/repos/$_repository/issues?state=all&access_token=$githubAccessToken' as Uri,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Issue.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load issues');
    }
  }

  Future<List<Issue>> fetchIssuesByLabel(String label) async {
    final response = await http.get(
      '$_baseUrl/repos/$_repository/issues?state=all&labels=$label&access_token=$githubAccessToken' as Uri,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Issue.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load issues');
    }
  }
}