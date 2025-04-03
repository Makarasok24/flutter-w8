enum Mode { add, edit }
class Student {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String email;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {'firstName': firstName, 'lastName': lastName, 'age': age, 'email': email};
  }

  @override
  bool operator ==(Object other) {
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
}
