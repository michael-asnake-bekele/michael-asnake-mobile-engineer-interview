import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_engineer_interview/models/employee.dart';

class EmployeeListNotifier with ChangeNotifier {
  List<Employee> employeeList = [];

  EmployeeListNotifier() {
    _generateEmployeeList(5);
  }

  _generateEmployeeList(int length) {
    Faker faker = Faker();
    employeeList = List.generate(
        length,
        (index) => Employee(
              faker.person.name(),
              '+${faker.phoneNumber.random.numberOfLength(13)}',
              faker.internet.email(),
              faker.company.position(),
              Random().nextDouble() * 100000,
            ));
    notifyListeners();
  }

  addEmployee(Employee employee) {
    employeeList.add(employee);
    notifyListeners();
  }

  removeEmployee(Employee employee) {
    employeeList.remove(employee);
    notifyListeners();
  }
}

final employeeListProvider =
    ChangeNotifierProvider((ref) => EmployeeListNotifier());
