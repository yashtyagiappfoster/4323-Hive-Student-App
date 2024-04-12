import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_student_app/Boxes/boxes.dart';
import 'package:hive_student_app/models/student_model.dart';
import 'package:hive_student_app/widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details App'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ValueListenableBuilder<Box<StudentModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, value, _) {
            var data = value.values.toList().cast<StudentModel>();
            return Expanded(
              child: ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(data[index].name.toString()),
                      subtitle: Column(
                        children: [
                          Text(data[index].course.toString()),
                          Text(data[index].college.toString()),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: [
                          CustomWidgets.customIconButton(() {
                            updateStudent(
                                data[index],
                                data[index].name.toString(),
                                data[index].age.toString(),
                                data[index].college.toString(),
                                data[index].course.toString());
                          }, Icons.edit, Colors.blue),
                          CustomWidgets.customIconButton(() {
                            deleteStudent(data[index]);
                          }, Icons.delete, Colors.red),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addStudent();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void deleteStudent(StudentModel studentModel) async {
    await studentModel.delete();
  }

  Future<void> addStudent() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Add Student'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomWidgets.customTextFormField(
                    nameController, 'Name', 'Enter Student Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomWidgets.customTextFormField(
                    ageController, 'Age', 'Enter age'),
                const SizedBox(
                  height: 10,
                ),
                CustomWidgets.customTextFormField(
                    collegeController, 'College', 'Enter College name'),
                const SizedBox(
                  height: 10,
                ),
                CustomWidgets.customTextFormField(
                    courseController, 'Course', 'Enter your course name'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                var data = StudentModel(
                    name: nameController.text,
                    age: ageController.text,
                    course: courseController.text,
                    college: collegeController.text);

                final box = Boxes.getData();
                box.add(data);
                data.save();

                nameController.text = '';
                ageController.text = '';
                courseController.text = '';
                collegeController.text = '';

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateStudent(StudentModel studentModel, String name, String age,
      String college, String course) async {
    nameController.text = name;
    ageController.text = age;
    collegeController.text = college;
    courseController.text = course;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Upadte Student'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomWidgets.customTextFormField(
                    nameController, 'Name', 'Enter Student Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomWidgets.customTextFormField(
                    ageController, 'Age', 'Enter age'),
                const SizedBox(
                  height: 10,
                ),
                CustomWidgets.customTextFormField(
                    collegeController, 'College', 'Enter College name'),
                const SizedBox(
                  height: 10,
                ),
                CustomWidgets.customTextFormField(
                    courseController, 'Course', 'Enter your course name'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                studentModel.name = nameController.text.toString();
                studentModel.age = ageController.text.toString();
                studentModel.college = collegeController.text.toString();
                studentModel.course = courseController.text.toString();

                studentModel.save();

                nameController.text = '';
                ageController.text = '';
                courseController.text = '';
                collegeController.text = '';

                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
