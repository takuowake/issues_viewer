import 'package:flutter/material.dart';
import '../../models/label.dart';

class LabelTile extends StatelessWidget {
  final Label label;

  const LabelTile({required Key key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label.name),
      onTap: () {
        Navigator.pushNamed(context, '/issueList',
            arguments: {'label': label}); // ラベルオブジェクトを渡す
      },
    );
  }
}