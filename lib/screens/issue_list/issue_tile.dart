import 'package:flutter/material.dart';
import '../../models/issue.dart';

class IssueTile extends StatelessWidget {
  final Issue issue;

  const IssueTile({Key? key, required this.issue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        issue.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '#${issue.number} opened by ${issue.user.login}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        // IssueのURLを取得し、WebView等で表示する
        final url = issue.htmlUrl;
        // TODO: URLを表示する処理を実装する
      },
    );
  }
}