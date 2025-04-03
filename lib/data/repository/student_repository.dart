import 'package:http/http.dart' as http;
import 'package:week_8_practice/model/student.dart';

abstract class StudentRepository {
  Future<Student> addStudent({
    required String firstName,
    required String lastName,
    required int age,
    required String email,
  });
  Future<List<Student>> getStudents();

  Future<http.Response> deleteStudent({required String id});

  Future<Student> updateStudent({
    required String id,
    required String firstName,
    required String lastName,
    required int age,
    required String email,
  });
}
