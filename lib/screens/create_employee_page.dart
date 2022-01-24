import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/providers/employee_list_provider.dart';
import 'package:mobile_engineer_interview/utils/app_bar_builder.dart';
import 'package:basic_utils/basic_utils.dart' hide Consumer;
import 'package:mobile_engineer_interview/widgets/custom_text_form_field_widget.dart';
import 'package:mobile_engineer_interview/widgets/header_text_widget.dart';
import 'package:sprintf/sprintf.dart';

/// Page for saving and editing employee data
///
/// Accepts [editEmployee] to initialize the form with
/// Accepts [index] to find and replace previous employee with edited employee data in the hive box
class CreateEmployeePage extends StatefulWidget {
  const CreateEmployeePage({Key? key, this.editEmployee, this.index})
      : super(key: key);
  final Employee? editEmployee;
  final int? index;

  @override
  _CreateEmployeePageState createState() => _CreateEmployeePageState();
}

class _CreateEmployeePageState extends State<CreateEmployeePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Employee employee = Employee.empty();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// initialize employee
    if (widget.editEmployee != null) {
      setState(() {
        employee = widget.editEmployee!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Create employee profile title
            const HeaderText(text: 'CREATE EMPLOYEE PROFILE'),
            /// New Employee form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                child: Column(children: [
                  /// Full name text field
                  CustomTextFormField(
                    onChanged: (input) {
                      employee.fullName = input;
                    },
                    hint: "Full Name *",
                    validator: (input) {
                      if (input != null) {
                        input = input.trim();
                      }
                      if (requiredFieldValidator(input) != null) {
                        return requiredFieldValidator(input);
                      }
                      if (!input!.contains(' ')) {
                        return 'Please enter full name';
                      }
                    },
                    initialValue: employee.fullName,
                  ),

                  /// Phone number text field
                  CustomTextFormField(
                    hint: 'Phone Number *',
                    onChanged: (input) {
                      employee.phoneNumber = input;
                    },
                    validator: (input) {
                      if (input != null) {
                        input = input.trim();
                      }
                      if (requiredFieldValidator(input) != null) {
                        return requiredFieldValidator(input);
                      }
                    },
                    initialValue: employee.phoneNumber,
                    isPhoneNumber: true,
                  ),

                  /// Email text form field
                  CustomTextFormField(
                    hint: 'Email *',
                    onChanged: (input) {
                      employee.email = input;
                    },
                    validator: (input) {
                      input = input!.trim();
                      if (input.isEmpty) {
                        return 'required';
                      }
                      if (!EmailUtils.isEmail(input)) {
                        return 'invalid email';
                      }
                    },
                    initialValue: employee.email,
                  ),

                  /// Position text form field
                  CustomTextFormField(
                    hint: 'Position *',
                    onChanged: (input) {
                      employee.position = input;
                    },
                    validator: requiredFieldValidator,
                    initialValue: employee.position,
                  ),

                  /// Salary text form field
                  CustomTextFormField(
                    hint: 'Salary *',
                    onChanged: (input) {
                      if (input != '') {
                        employee.salary =
                            double.parse(input.replaceAll(RegExp(', '), ''));
                      }
                    },
                    isDecimal: true,
                    validator: (input) {
                      if (requiredFieldValidator(input) != null) {
                        return requiredFieldValidator(input);
                      }
                      try {
                        double salary =
                            double.parse(input!.trim().replaceAll(',', ''));
                        if (salary < 0) {
                          return 'Salary must be greater than or equal to 0';
                        }
                      } catch (exception) {
                        return 'Invalid input, please enter a decimal number';
                      }
                    },
                    initialValue: employee.salary != -1.0
                        ? sprintf('%.2f', [employee.salary])
                        : '',
                  ),

                  /// Save button
                  _buildSaveButton(),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// creates a save button to handle form submission
  Consumer _buildSaveButton() {
    return Consumer(
      builder: (context, ref, child) {
        /// get a reference to employee list notifier using the employeeListProvider
        EmployeeListNotifier employeeListNotifier = ref.watch(employeeListProvider);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0),
          child: SizedBox(
            width: double.maxFinite,
            child: MaterialButton(
              color: Colors.black,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
                child: Text(
                  'SAVE',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  _handleSave(employeeListNotifier);
                }
              },
            ),
          ),
        );
      },
    );
  }

  /// Handles saving [Employee] data from the form
  ///
  /// takes [employeeListNotifier] for saving employee to the hive box
  _handleSave(EmployeeListNotifier employeeListNotifier) {
    String successMessage;
    if (widget.editEmployee != null) {
      //is edit mode
      employeeListNotifier.editEmployee(widget.index!, employee);
      successMessage = 'Employee data successfully updated ';
      Navigator.of(context).pop();
    } else {
      successMessage = 'New Employee Successfully saved';
      employeeListNotifier.addEmployee(employee);
    }
    formKey.currentState?.reset();
    _showSuccessSnackBar(successMessage);
  }

  /// accepts [successMessage] string and shows a snack bar
  _showSuccessSnackBar(String successMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            Text(
              successMessage,
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
      ),
    );
  }

  /// Validates if the [input] string is null or empty
  String? requiredFieldValidator(input) {
    if (input == null || input.isEmpty) {
      return "this field is required";
    }
  }
}
