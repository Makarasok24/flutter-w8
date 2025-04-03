import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_8_practice/data/repository/firebase_student_repository.dart';
import 'package:week_8_practice/data/repository/student_repository.dart';
import 'package:week_8_practice/ui/providers/student_provider.dart';
import 'package:week_8_practice/ui/screens/app.dart';

void main() async {
  final StudentRepository studentRepository = FirebaseStudentRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => StudentProvider(studentRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const App()),
    ),
  );
}
