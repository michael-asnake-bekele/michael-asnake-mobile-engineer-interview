import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/providers/employee_list_provider.dart';
import 'package:mobile_engineer_interview/screens/create_employee_page.dart';
import 'package:mobile_engineer_interview/utils/app_bar_builder.dart';

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
            ref.read(employeeListProvider);
        return ListView.builder(
            itemCount: employeeListNotifier.employeeList.length,
            padding: const EdgeInsets.only(top: 8, bottom: 82),
            itemBuilder: (context, index) {
              Employee employee = employeeListNotifier.employeeList[index];
              return EmployeeListTile(employee: employee);
            });
      }),
      drawer: Drawer(),
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

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile({
    Key? key,
    required this.employee,
  }) : super(key: key);

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 0)),
        child: Row(
          children: [
            Image.network(
              'https://www.w3schools.com/howto/img_avatar.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    employee.fullName,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                    employee.position
                ),
                Text(
                    employee.phoneNumber
                ),
                Text(
                    employee.email
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
