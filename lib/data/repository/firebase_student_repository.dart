import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:week_8_practice/data/DTO/dto_student.dart';
import 'package:week_8_practice/data/repository/student_repository.dart';
import 'package:week_8_practice/model/student.dart';

class FirebaseStudentRepository extends StudentRepository {
  static const String baseUrl =
      "https://week-8-practice-3484f-default-rtdb.asia-southeast1.firebasedatabase.app";
  static const String students = "students";
  static const String allStudentsUrl = '$baseUrl/$students.json';
  Uri uri = Uri.parse(allStudentsUrl);

  @override
  Future<Student> addStudent({
    required String firstName,
    required String lastName,
    required int age,
    required String email,
  }) async {
    //create a new student
    final newStudentData = {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'email': email,
    };
    final http.Response response = await http.post(
      uri,
      body: json.encode(newStudentData),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Filed to add student");
    }

    //firebase returns the new id in 'name'
    final newId = json.decode(response.body)['firstName'];

    //return created student

    return Student(
      id: newId,
      firstName: firstName,
      lastName: lastName,
      age: age,
      email: email,
    );
  }

  @override
  Future<List<Student>> getStudents() async {
    final http.Response response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception("Filed to load students");
    }

    final studentData = json.decode(response.body) as Map<String, dynamic>?;

    if (studentData == null) return [];
    return studentData.entries
        .map((entry) => DtoStudent.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  Future<http.Response> deleteStudent({required String id}) async {
    Uri uri = Uri.parse('$baseUrl/$students/$id.json');
    final http.Response response = await http.delete(uri);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception("Filed to delete student");
    }
    return response;
  }

  @override
  Future<Student> updateStudent({
    required String id,
    required String firstName,
    required lastName,
    required int age,
    required String email,
  }) async {
    Uri uri = Uri.parse('$baseUrl/$students/$id.json');
    final updateStudentData = {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'email': email,
    };

    final http.Response reresponse = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updateStudentData),
    );

    if (reresponse.statusCode != HttpStatus.ok) {
      throw Exception("Filed to update student");
    }

    return Student(
      id: id,
      firstName: firstName,
      lastName: lastName,
      age: age,
      email: email,
    );
  }
}
