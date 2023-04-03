import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/issue.dart';
import '../repositories/github_repository.dart';
import 'github_api.dart';

final issuesRepositoryProvider = Provider((ref) => IssuesRepository(githubRepository: GithubRepository(api: ref.watch(githubApiProvider))));

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