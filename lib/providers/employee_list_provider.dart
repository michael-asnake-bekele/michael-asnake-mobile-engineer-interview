import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_engineer_interview/models/employee.dart';

class EmployeeListNotifier with ChangeNotifier {
  List<Employee> employeeList = [];

  EmployeeListNotifier() {
    _generateEmployeeList(5);
  }

  _generateEmployeeList(int length) {
    employeeList = List.generate(
        length,
        (index) => Employee(
              'John Doe',
              '+2519112233',
              'john.doe${index + 1}@gmail.com',
              'Position ${index + 1}',
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
