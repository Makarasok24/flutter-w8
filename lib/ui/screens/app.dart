import 'package:flutter/material.dart';
import 'package:week_8_practice/model/student.dart';
import 'package:week_8_practice/ui/providers/student_provider.dart';
import 'package:week_8_practice/ui/screens/widgets/student_form.dart';
import 'package:week_8_practice/utils/animations_util.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  void _onAddPressed(BuildContext context) async {
    Navigator.of(
      context,
    ).push(AnimationUtils.createTopToBottomRoute(StudentForm(mode: Mode.add)));
  }

  void _onDeletePress(BuildContext context, String id) {
    final StudentProvider studentProvider = context.read<StudentProvider>();
    studentProvider.deleteStudent(id);
  }

  void _onUpdateStudent(BuildContext context, Student student) {
    Navigator.of(context).push(
      AnimationUtils.createTopToBottomRoute(
        StudentForm(mode: Mode.edit, student: student),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    Widget content = Text('');
    if (studentProvider.isLoading) {
      content = CircularProgressIndicator();
    } else if (studentProvider.hasData) {
      List<Student> students = studentProvider.students!.data!;
      print(students.length);

      if (students.isEmpty) {
        content = Text("No data yet");
      } else {
        content = ListView.builder(
          itemCount: students.length,
          itemBuilder:
              (context, index) => ListTile(
                title: Row(
                  children: [
                    Text(students[index].firstName),
                    SizedBox(width: 10),
                    Text(students[index].lastName),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Text("${students[index].age}"),
                    Text(students[index].email),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed:
                          () => _onDeletePress(context, students[index].id),
                    ),
                    IconButton(
                      onPressed:
                          () => _onUpdateStudent(context, students[index]),
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ],
                ),
              ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _onAddPressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(child: content),
    );
  }
}
