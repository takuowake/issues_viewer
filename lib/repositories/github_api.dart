import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubApi {
  final String githubAccessToken = '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';

  //GETリクエストを送信し、レスポンスを受け取り、JSON形式のデータをリストとして返す
  Future<List<dynamic>> getFlutterIssues() async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues'), headers: {
      'Authorization': 'token $githubAccessToken',
      'Accept': 'application/vnd.github.v3+json',
    });
    ///レスポンスを受け取れているか確認
    print(response);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from Github API');
    }
  }
}