import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Employee{
  Employee({this. id, this.name, this.sex, this.position});
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? sex;


  @HiveField(3)
  String? position;
}