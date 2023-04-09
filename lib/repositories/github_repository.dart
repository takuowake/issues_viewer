import '../models/issue.dart';
import 'github_api.dart';

class GithubRepository {
  final GithubApi api;

  GithubRepository({required this.api});

  Future<List<Issue>> getIssues(IssueLabel issueLabel, {int page = 1}) async {
    switch (issueLabel) {
      case IssueLabel.all:
        return await api.fetchAllIssues(page);
      case IssueLabel.pWebView:
        return await api.fetchIssuesByLabel('p:+webview', page);
      case IssueLabel.pSharedPreferences:
        return await api.fetchIssuesByLabel('p:+shared_preferences', page);
      case IssueLabel.waitingForCustomerResponse:
        return await api.fetchIssuesByLabel('waiting+for+customer+response', page);
      case IssueLabel.newFeature:
        return await api.fetchIssuesByLabel('new+feature', page);
      case IssueLabel.pShare:
        return await api.fetchIssuesByLabel('p:+share', page);
      default:
        throw Exception('Invalid issue state');
    }
  }
}