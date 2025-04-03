import 'package:week_8_practice/model/student.dart';

class DtoStudent {
  static Student fromJson(String id, Map<String, dynamic> json) {
    return Student(
      id: id,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      email: json['email'] as String? ?? '',
    );
  }

  static Map<String, dynamic> toJson(Student student) {
    return {
      'firstName': student.firstName,
      'lastName': student.lastName,
      'age': student.age,
      'email': student.email,
    };
  }
}
