import '../models/issue.dart';
import '../utils/enums/issue_state.dart';
import '../repositories/github_repository.dart';

class IssuesRepository {
  final GithubRepository githubRepository;

  IssuesRepository({required this.githubRepository});

  Map<IssueState, List<Issue>> _cachedIssues = {};

  Future<List<Issue>> getIssues(IssueState issueState) async {
    if (_cachedIssues.containsKey(issueState)) {
      return _cachedIssues[issueState]!;
    } else {
      final issues = await githubRepository.getIssues(issueState);
      _cachedIssues[issueState] = issues;
      return issues;
    }
  }
}