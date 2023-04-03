import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/issue.dart';

final githubApiProvider = Provider((ref) => GithubApi());


class GithubApi {
  static const String _baseUrl = 'https://api.github.com';
  static const String _repository = 'flutter/flutter';
  final String githubAccessToken = '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';

  Future<List<Issue>> fetchIssues() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/repos/$_repository/issues?state=all&per_page=100'),
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

  Future<List<Issue>> fetchIssuesByLabel(String label) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/repos/$_repository/issues?state=all&labels=$label&per_page=100'),
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
}