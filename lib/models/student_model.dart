import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String age;

  @HiveField(2)
  String college;

  @HiveField(3)
  String course;

  StudentModel({
    required this.name,
    required this.age,
    required this.course,
    required this.college,
  });
}
