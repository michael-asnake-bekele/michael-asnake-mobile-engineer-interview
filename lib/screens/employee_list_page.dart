import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/providers/employee_list_provider.dart';
import 'package:mobile_engineer_interview/screens/create_employee_page.dart';
import 'package:mobile_engineer_interview/screens/employee_details_page.dart';
import 'package:mobile_engineer_interview/utils/app_bar_builder.dart';
import 'package:mobile_engineer_interview/widgets/employee_list_tile_widget.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Consumer(builder: (context, ref, child) {
        EmployeeListNotifier employeeListNotifier =
            ref.watch(employeeListProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
              child: Text(
                'EMPLOYEES',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateEmployeePage(editEmployee: employee, index: index)));
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
                          // MaterialButton(
                          //   onPressed: (){
                          //     employeeListNotifier.generateEmployeeList(10);
                          //   },
                          //   shape: StadiumBorder(),
                          //   color: Colors.black,
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       const Icon(
                          //         Icons.add,
                          //         color: Colors.white,
                          //       ),
                          //       Text(
                          //           'Generate Random Data',
                          //         style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
      drawer: Drawer(
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
      ),
      floatingActionButton: MaterialButton(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                "Add Employee",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateEmployeePage()));
        },
      ),
    );
  }
}


