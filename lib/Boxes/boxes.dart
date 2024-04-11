import 'package:hive/hive.dart';
import 'package:hive_student_app/models/student_model.dart';

class Boxes {
  static Box<StudentModel> getData() => Hive.box<StudentModel>('students');
}
