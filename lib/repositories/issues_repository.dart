import '../models/issue.dart';
import '../repositories/github_repository.dart';

class IssuesRepository {
  final GithubRepository githubRepository;

  IssuesRepository({required this.githubRepository});


  Future<List<Issue>> getIssues(IssueLabel issueLabel, page) async {
  return await githubRepository.getIssues(issueLabel);
  }
}