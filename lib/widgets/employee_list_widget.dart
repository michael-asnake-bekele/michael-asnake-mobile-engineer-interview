import 'package:flutter/material.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/providers/employee_list_provider.dart';
import 'package:mobile_engineer_interview/screens/create_employee_page.dart';
import 'package:mobile_engineer_interview/screens/employee_details_page.dart';

import 'employee_list_tile_widget.dart';

class EmployeesList extends StatelessWidget {
  const EmployeesList({
    Key? key,
    required this.employeeListNotifier,
  }) : super(key: key);

  final EmployeeListNotifier employeeListNotifier;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: employeeListNotifier.employeesBox.length,
            padding: const EdgeInsets.only(bottom: 120),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              Employee employee = employeeListNotifier.employeesBox.getAt(index);
              return EmployeeListTile(
                key: UniqueKey(),
                employee: employee,
                onDeleteTapped: () {
                  showDeleteConfirmationDialog(context, employee, index);
                },
                onEditTapped: () {
                  _goToEditPage(context, index, employee);
                },
                onTapped: () {
                  _goToEmployeeDetails(context, employee);
                },
              );
            },
          ),
          Visibility(
            visible: employeeListNotifier.employeesBox.length == 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.list,
                    size: 72,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'There are no employees saved.',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _goToEmployeeDetails(BuildContext context, Employee employee) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EmployeeDetailsPage(
              employee: employee,
            )));
  }

  /// Navigates to [CreateEmployeePage] with required edit data
  ///
  /// accepts [index] of the employee list (which corresponds to the index of
  /// the employee in the hive box)
  ///
  /// accepts [employee] which has the current employee data which will be used to populate to the edit form
  void _goToEditPage(BuildContext context, int index, Employee employee) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => CreateEmployeePage(
              index: index,
              editEmployee: employee,
            )
          )
        );
  }
  
  /// shows delete confirmation alert dialog 
  void showDeleteConfirmationDialog(BuildContext context, Employee employee, int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete employee?'),
              content: Text('Are you sure you want to delete ${employee.fullName}?'),
              actions: [
                /// Yes button
                MaterialButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      /// remove employee from hive box
                      employeeListNotifier.removeEmployee(index);
                      /// dismiss dialog
                      Navigator.pop(context);
                      _showDeletedSnackBar(context);
                    }
                ),

                /// Cancel button
                MaterialButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      /// dismiss dialog
                      Navigator.pop(context);
                    }
                ),
              ],
            ));
  }

  _showDeletedSnackBar(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            'Successfully deleted employee',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.green[600],
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
