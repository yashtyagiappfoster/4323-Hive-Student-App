import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_student_app/models/student_model.dart';
import 'package:hive_student_app/views/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox('students');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hive Student App",
      home: HomeScreen(),
    );
  }
}
