import 'package:flutter/material.dart';
import '../../models/label.dart';

class LabelTab extends StatelessWidget {
  final List<Label> labels;

  const LabelTab({Key? key, required this.labels, String? label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Labels'),
      ),
      body: ListView.builder(
        itemCount: labels.length,
        itemBuilder: (BuildContext context, int index) {
          final label = labels[index];
          return ListTile(
            title: Text(label.name),
            onTap: () {
              Navigator.pop(context, label); // ラベルオブジェクトを渡す
            },
          );
        },
      ),
    );
  }
}