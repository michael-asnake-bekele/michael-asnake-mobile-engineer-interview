import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_engineer_interview/providers/employee_list_provider.dart';
import 'package:mobile_engineer_interview/utils/app_bar_builder.dart';
import 'package:mobile_engineer_interview/widgets/add_employee_button_widget.dart';
import 'package:mobile_engineer_interview/widgets/custom_drawer_widget.dart';
import 'package:mobile_engineer_interview/widgets/employee_list_widget.dart';
import 'package:mobile_engineer_interview/widgets/header_text_widget.dart';

/// For displaying employee list page
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
            const HeaderText(text: 'EMPLOYEES'),
            EmployeesList(employeeListNotifier: employeeListNotifier),
          ],
        );
      }),
      drawer: const CustomDrawer(),
      floatingActionButton: const AddEmployeeButton(),
    );
  }
}


