import '../models/issue.dart';
import '../repositories/github_api.dart';

///Github APIを利用してIssueを取得
class GithubRepository {
  final GithubApi api;

  GithubRepository({required this.api});

  Future<List<Issue>> getIssues(IssueLabel issueLabel) async {
    switch (issueLabel) {
      case IssueLabel.all:
        return await api.fetchIssues();
      case IssueLabel.pWebView:
        return await api.fetchIssuesByLabel('p:+webview');
      case IssueLabel.pSharedPreferences:
        return await api.fetchIssuesByLabel('p:+shared_preferences');
      case IssueLabel.waitingForCustomerResponse:
        return await api.fetchIssuesByLabel('waiting+for+customer+response');
      case IssueLabel.newFeature:
        return await api.fetchIssuesByLabel('new+feature');
      case IssueLabel.pShare:
        return await api.fetchIssuesByLabel('p:+share');
      default:
        throw Exception('Invalid issue state');
    }
  }
}