import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_engineer_interview/providers/employee_list_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  EmployeeListNotifier employeeNotifier =
                  ref.watch(employeeListProvider);
                  return MaterialButton(
                    color: Colors.black,
                    child: const Text(
                      'Add Random Employees',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      employeeNotifier.generateEmployeeList(10);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
