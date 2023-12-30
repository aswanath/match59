import 'package:flutter/material.dart';
import 'package:match5/app.dart';
import 'package:match5/core/dependency_injection/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const Match5App());
}
