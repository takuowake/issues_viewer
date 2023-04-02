import '../models/issue.dart';
import '../utils/enums/issue_state.dart';
import '../repositories/github_api.dart';

class GithubRepository {
  final GithubApi api;

  GithubRepository({required this.api});

  Future<List<Issue>> getIssues(IssueState issueState) async {
    switch (issueState) {
      case IssueState.all:
        return await api.fetchIssues();
      case IssueState.webView:
        return await api.fetchIssuesByLabel('p: webview');
      case IssueState.sharedPreferences:
        return await api.fetchIssuesByLabel('p: shared_preferences');
      case IssueState.waitingForCustomerResponse:
        return await api.fetchIssuesByLabel('waiting for customer response');
      case IssueState.severeNewFeature:
        return await api.fetchIssuesByLabel('severe: new feature');
      case IssueState.share:
        return await api.fetchIssuesByLabel('p: share');
      default:
        throw Exception('Invalid issue state');
    }
  }
}