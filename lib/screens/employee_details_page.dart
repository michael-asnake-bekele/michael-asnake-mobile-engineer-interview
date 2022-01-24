import 'package:flutter/material.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/screens/employee_list_page.dart';
import 'package:mobile_engineer_interview/utils/app_bar_builder.dart';
import 'package:mobile_engineer_interview/widgets/employee_list_tile_widget.dart';
import 'package:mobile_engineer_interview/widgets/loan_record_list_tile_widget.dart';

class EmployeeDetailsPage extends StatefulWidget {
  const EmployeeDetailsPage({Key? key, required this.employee})
      : super(key: key);
  final Employee employee;

  @override
  _EmployeeDetailsPageState createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            EmployeeListTile(
              employee: widget.employee,
              onDeleteTapped: null, // empty call back
              onEditTapped: null,
              onTapped: null,
              disableGestures: true,
            ),
            const SizedBox(
              height: 32,
            ),
            const LoanRecordsList(),
          ],
        ),
      ),
    );
  }
}

/// For showing random employee loan record data
class LoanRecordsList extends StatelessWidget {
  const LoanRecordsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        LoanYearHeader(year: '2022'),
        LoanRecordListTile(),
        LoanRecordListTile(),
        LoanYearHeader(year: '2021'),
        LoanRecordListTile(),
        LoanRecordListTile(),
        LoanYearHeader(year: '2020'),
        LoanRecordListTile(),
      ],
    );
  }
}

/// Displays [year] string and servers as a divider
class LoanYearHeader extends StatelessWidget {
  const LoanYearHeader({
    Key? key,
    required this.year,
  }) : super(key: key);

  final String year;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Text(
          year,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(width: 32),
        const Expanded(
          child: Divider(
            thickness: 1.5,
          ),
        ),
      ]),
    );
  }
}
