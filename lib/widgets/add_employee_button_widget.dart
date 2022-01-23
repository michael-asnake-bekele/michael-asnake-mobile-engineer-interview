import 'package:flutter/material.dart';
import 'package:mobile_engineer_interview/screens/create_employee_page.dart';
class AddEmployeeButton extends StatelessWidget {
  const AddEmployeeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
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
    );
  }
}
