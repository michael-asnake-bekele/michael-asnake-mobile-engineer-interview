
import 'package:hive_flutter/hive_flutter.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee{
  @HiveField(1)
  late String fullName;
  @HiveField(2)
  late String phoneNumber;
  @HiveField(3)
  late String email;
  @HiveField(4)
  late String position;
  @HiveField(5)
  late double salary;

  Employee(
    this.fullName,
    this.phoneNumber,
    this.email,
    this.position,
    this.salary
  );

  Employee.empty(){
    fullName = '';
    phoneNumber = '';
    email = '';
    position = '';
    salary = 0;
  }

}