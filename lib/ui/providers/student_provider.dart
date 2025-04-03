import 'package:flutter/material.dart';
import 'package:week_8_practice/data/repository/student_repository.dart';
import 'package:week_8_practice/model/student.dart';
import 'package:week_8_practice/ui/providers/async_value.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _repository;
  AsyncValue<List<Student>>? students;

  StudentProvider(this._repository) {
    getStudents();
  }

  bool get isLoading =>
      students != null && students!.state == AsyncValueState.loading;
  bool get hasData =>
      students != null && students!.state == AsyncValueState.success;

  void getStudents() async {
    try {
      // 1- loading state
      students = AsyncValue.loading();
      await Future.delayed(Duration(seconds: 1));
      notifyListeners();

      // 2 - Fetch users
      students = AsyncValue.success(await _repository.getStudents());

      print("SUCCESS: list size ${students!.data!.length.toString()}");

      // 3 - Handle errors
    } catch (error) {
      print("ERROR: $error");
      students = AsyncValue.error(error);
    }
    notifyListeners();
  }

  void addStudent(
    String firstName,
    String lastName,
    int age,
    String email,
  ) async {
    // 1- Call repo to add
    await _repository.addStudent(
      firstName: firstName,
      lastName: lastName,
      age: age,
      email: email,
    );

    // 2- Call repo to fetch
    getStudents();
  }

  void deleteStudent(String id) async {
    // 1- Call repo to add
    await _repository.deleteStudent(id: id);

    // 2- Call repo to fetch
    getStudents();
    notifyListeners();
  }

  void updateStudent(
    String id,
    String firstName,
    String lastName,
    int age,
    String email,
  ) async {
    // 1- Call repo to add
    await _repository.updateStudent(
      id: id,
      firstName: firstName,
      lastName: lastName,
      age: age,
      email: email,
    );

    // 2- Call repo to fetch
    getStudents();
  }
}
