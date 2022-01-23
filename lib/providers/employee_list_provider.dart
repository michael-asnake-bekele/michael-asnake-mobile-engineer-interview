import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_engineer_interview/models/employee.dart';

/// Serves as a central point of access for the app's [Employee] list stored in the hive box
///
/// Allows adding, editing/replacing, and removing [Employee] objects to and from the box
///
class EmployeeListNotifier with ChangeNotifier {
  /// Opens the [Box] of employees named "employees_box" created in the app's Main function
  final employeesBox = Hive.box('employees_box');

  /// Generates a random fake [Employee] list and saves it to the hive box
  generateEmployeeList(int length) {
    /// initialize faker for generating random data
    Faker faker = Faker();

    /// Generate List
    List<Employee> employeeList = List.generate(
        length,
        (index) => Employee(
              '${faker.person.firstName()} ${faker.person.lastName()}',

              /// generate random full name
              '+${faker.phoneNumber.random.numberOfLength(13)}',

              /// generate random phone number
              faker.internet.email(),

              /// generate random email
              faker.company.position(),

              /// generate random position
              Random().nextDouble() * 100000,

              /// generate random salary
            ));

    /// Add all employees in the list to the hive box
    for (var employee in employeeList) {
      employeesBox.add(employee);
    }
    notifyListeners();
  }

  /// Saves [Employee] objects to the hive box
  addEmployee(Employee employee) {
    employeesBox.add(employee);
    notifyListeners();
  }

  /// Deletes [Employee] at the given index from the hive box
  removeEmployee(int index) {
    employeesBox.deleteAt(index);
    notifyListeners();
  }

  /// Takes edited [Employee] object and saves it at the given index in the hive box
  editEmployee(int index, Employee editedEmployee) {
    employeesBox.putAt(index, editedEmployee);
    notifyListeners();
  }
}

/// Initializes an [EmployeeListNotifier] provider which can be accessed through out the app
final employeeListProvider =
    ChangeNotifierProvider((ref) => EmployeeListNotifier());
