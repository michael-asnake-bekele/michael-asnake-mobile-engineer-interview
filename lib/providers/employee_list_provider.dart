import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_engineer_interview/models/employee.dart';

class EmployeeListNotifier with ChangeNotifier {
  List<Employee> employeeList = [];
  final employeesBox = Hive.box('employees_box');

  EmployeeListNotifier();


  generateEmployeeList(int length) {
    Faker faker = Faker();
    employeeList = List.generate(
        length,
        (index) => Employee(
              '${faker.person.firstName()} ${faker.person.lastName()}',
              '+${faker.phoneNumber.random.numberOfLength(13)}',
              faker.internet.email(),
              faker.company.position(),
              Random().nextDouble() * 100000,
            ));
    for (var employee in employeeList) {
      employeesBox.add(employee);
    }
    notifyListeners();
  }

  addEmployee(Employee employee) {
    employeesBox.add(employee);
    notifyListeners();
  }

  removeEmployee(int index) {
    employeesBox.deleteAt(index);
    notifyListeners();
  }

  editEmployee(int index, Employee employee){
    employeesBox.putAt(index, employee);
    notifyListeners();
  }
}

final employeeListProvider =
    ChangeNotifierProvider((ref) => EmployeeListNotifier());
