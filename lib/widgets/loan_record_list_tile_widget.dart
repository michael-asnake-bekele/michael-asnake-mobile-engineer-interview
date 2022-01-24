import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_engineer_interview/screens/employee_details_page.dart';
import 'package:sprintf/sprintf.dart';

/// For displaying loan record record data in [EmployeeDetailsPage]
class LoanRecordListTile extends StatefulWidget {
  const LoanRecordListTile({Key? key}) : super(key: key);

  @override
  _LoanRecordListTileState createState() => _LoanRecordListTileState();
}

class _LoanRecordListTileState extends State<LoanRecordListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 0)),
        child: Row(
          children: [
            SizedBox(
              width: 95,
              height: double.infinity,
              child: Container(
                color: Colors.grey[300],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                    Text(
                      'Jan',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.grey[400]),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('BORROWED:'),
                          Text(getRandomAmount()),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text('RECEIVABLE:'),
                          Text(getRandomAmount()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// generates random amount of money for displaying as a loan receivable or borrowed amount
  String getRandomAmount() {
    return sprintf('\$ %.2f', [Random().nextDouble() * 10000]);
  }
}
