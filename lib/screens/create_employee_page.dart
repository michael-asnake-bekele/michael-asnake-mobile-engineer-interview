import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/providers/employee_list_provider.dart';
import 'package:mobile_engineer_interview/utils/app_bar_builder.dart';
import 'package:basic_utils/basic_utils.dart' hide Consumer;

class CreateEmployeePage extends StatefulWidget {
  const CreateEmployeePage({Key? key, this.editEmployee, this.index}) : super(key: key);
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
    if(widget.editEmployee != null){
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
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Text(
                'CREATE EMPLOYEE PROFILE',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Form(
                key: formKey,
                child: Column(children: [
                  getTextFormField(
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
                  getTextFormField(
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
                  getTextFormField(
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
                  getTextFormField(
                      hint: 'Position *',
                      onChanged: (input) {
                        employee.position = input;
                      },
                      validator: requiredFieldValidator,
                    initialValue: employee.position,

                  ),
                  getTextFormField(
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
                    initialValue: '${employee.salary}',

                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      EmployeeListNotifier employeeListNotifier =
                          ref.watch(employeeListProvider);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48.0),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: MaterialButton(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 18),
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
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleSave(EmployeeListNotifier employeeListNotifier) {
    String successMessage;
    if(widget.editEmployee != null){
      //is edit mode
      employeeListNotifier.editEmployee(widget.index!, employee);
      successMessage = 'Employee data successfully updated ';
      Navigator.of(context).pop();
    }else{
      successMessage = 'New Employee Successfully saved';
      employeeListNotifier.addEmployee(employee);
    }
    formKey.currentState?.reset();
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
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green[600],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String? requiredFieldValidator(input) {
    if (input == null || input.isEmpty) {
      return "this field is required";
    }
  }

  Widget getTextFormField(
      {required String hint,
      required void Function(String) onChanged,
      required String? Function(String?) validator,
      bool isDecimal = false,
      bool isPhoneNumber = false,
      String initialValue = ''}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          hint,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            initialValue: initialValue,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: onChanged,
            validator: validator,
            keyboardType: isDecimal
                ? const TextInputType.numberWithOptions(
                    decimal: true, signed: false)
                : isPhoneNumber? TextInputType.phone :TextInputType.name,
          ),
        ),
      ],
    );
  }
}
