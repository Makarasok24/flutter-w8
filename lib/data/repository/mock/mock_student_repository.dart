import 'package:http/http.dart';
import 'package:week_8_practice/data/repository/student_repository.dart';
import 'package:week_8_practice/model/student.dart';

class MockStudentRepository extends StudentRepository {
  final List<Student> students = [];

  @override
  Future<Student> addStudent({
    required String firstName,
    required String lastName,
    required int age,
    required String email,
  }) {
    return Future.delayed(Duration(seconds: 2), () {
      Student newStudent = Student(
        id: "001",
        firstName: "Makara",
        lastName: "Sok",
        age: 21,
        email: "makarasok1624@gmail.com",
      );
      students.add(newStudent);
      return newStudent;
    });
  }

  @override
  Future<List<Student>> getStudents() {
    return Future.delayed(Duration(seconds: 2), () => students);
  }

  @override
  Future<Response> deleteStudent({required String id}) {
    return Future.delayed(Duration(seconds: 2), () => Response("Success", 200));
  }

  @override
  Future<Student> updateStudent({
    required String id,
    required String firstName,
    required String lastName,
    required int age,
    required String email,
  }) {
    return Future.delayed(Duration(seconds: 2), () {
      Student testUpdateStudent = Student(
        id: "001",
        firstName: "Sok",
        lastName: "Makara",
        age: 20,
        email: "makarasok.it@gmail.com",
      );
      students.add(testUpdateStudent);
      return testUpdateStudent;
    });
  }
}
