import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:issues_viewer/screens/issue_viewer.dart';

void main() {
  runApp(const ProviderScope(child: IssueViewer()));
}