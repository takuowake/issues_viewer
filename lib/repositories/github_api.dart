import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/issue.dart';

class GithubApi {
  final String githubAccessToken = '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';

  //GETリクエストを送信し、レスポンスを受け取り、JSON形式のデータをリストとして返す
  Future<List<Issue>> getFlutterIssues(int page, int perPage) async {
    final response = await http.get(
      Uri.parse(
          'https://api.github.com/repos/flutter/flutter/issues?page=$page&per_page=perPage',
      ),
      headers: {
        'Authorization': 'token $githubAccessToken',
        'Accept': 'application/vnd.github.v3+json',
      },
    );

    //レスポンスを受け取れているか確認
    print(response);

    if (response.statusCode == 200) {
      final List<dynamic> issuesJson = json.decode(response.body);
      final List<Issue> issues = issuesJson.map((json) => Issue.fromJson(json)).toList();
      return issues;
    } else {
      throw Exception('Failed to load data from Github API');
    }
  }
}