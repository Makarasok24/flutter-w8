import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_8_practice/model/student.dart';
import 'package:week_8_practice/ui/providers/student_provider.dart';

class StudentForm extends StatefulWidget {
  final Mode mode;
  final Student? student;
  const StudentForm({super.key, required this.mode, this.student});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.mode != Mode.add && widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _ageController.text = widget.student!.age.toString();
      _emailController.text = widget.student!.email;
    }
  }

  void _submitForm() {
    if (_globalKey.currentState!.validate()) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      int age = int.tryParse(_ageController.text) ?? 0;
      String email = _emailController.text;

      if (widget.mode == Mode.add) {
        final StudentProvider studentProvider = context.read<StudentProvider>();
        studentProvider.addStudent(firstName, lastName, age, email);
        Navigator.pop(context);
      } else {
        final StudentProvider studentProvider = context.read<StudentProvider>();
        studentProvider.updateStudent(
          widget.student!.id,
          firstName,
          lastName,
          age,
          email,
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == Mode.add ? 'Add Student' : 'Update Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(hintText: 'Input first name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: 'Input last name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(hintText: 'Input age'),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input some text';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Input email'),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input some text';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
