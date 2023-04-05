import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/issue.dart';
import '../repositories/github_repository.dart';
import 'github_api.dart';

final issuesRepositoryProvider = Provider((ref) => IssuesRepository(githubRepository: GithubRepository(api: ref.watch(githubApiProvider))));

class IssuesRepository {
  final GithubRepository githubRepository;

  IssuesRepository({required this.githubRepository});

  Map<IssueLabel, List<Issue>> _cachedIssues = {};

  Future<List<Issue>> getIssues(IssueLabel issueLabel) async {
    if (_cachedIssues.containsKey(issueLabel)) {
      return _cachedIssues[issueLabel]!;
    } else {
      final issues = await githubRepository.getIssues(issueLabel);
      if (issues == null) {
        throw Exception('Failed to load issues');
      }
      _cachedIssues[issueLabel] = issues;
      return issues;
    }
  }
}