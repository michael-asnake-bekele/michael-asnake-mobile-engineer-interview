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
              Employee employee =
              employeeListNotifier.employeesBox.getAt(index);
              return EmployeeListTile(
                key: UniqueKey(),
                employee: employee,
                onDeleteTapped: () {
                  employeeListNotifier.removeEmployee(index);
                },
                onEditTapped: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateEmployeePage(
                        index: index,
                        editEmployee: employee,
                      )));
                },
                onTapped: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EmployeeDetailsPage(
                        employee: employee,
                      )));
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
}
