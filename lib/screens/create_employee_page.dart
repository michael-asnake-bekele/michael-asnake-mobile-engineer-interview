import 'package:flutter/material.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/utils/app_bar_builder.dart';

class CreateEmployeePage extends StatefulWidget {
  const CreateEmployeePage({Key? key}) : super(key: key);

  @override
  _CreateEmployeePageState createState() => _CreateEmployeePageState();
}

class _CreateEmployeePageState extends State<CreateEmployeePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Employee employee = Employee.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 32),
              child: Text(
                'CREATE EMPLOYEE PROFILE',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
              child: Form(
                key: formKey,
                child: Column(children: [
                  getTextFormField(
                    onChanged: (input){
                      employee.fullName = input;
                      print(employee.fullName);
                    },
                    hint: "Full Name *",
                    validator: requiredFieldValidator
                  ),
                  getTextFormField(
                      hint: 'Phone Number *',
                      onChanged: (input){
                        employee.phoneNumber = input;
                        print(employee.phoneNumber);
                      },
                      validator: requiredFieldValidator
                  ),
                  getTextFormField(
                      hint: 'Email *',
                      onChanged: (input){
                        employee.email = input;
                        print(employee.email);
                      },
                      validator: requiredFieldValidator
                  ),
                  getTextFormField(
                      hint: 'Position *',
                      onChanged: (input){
                        employee.position = input;
                        print(employee.position);
                      },
                      validator: requiredFieldValidator
                  ),
                  getTextFormField(
                    hint: 'Salary *',
                    onChanged: (input){
                      employee.salary = double.parse(input.replaceAll(RegExp(', '), ''));
                      print(employee.salary);
                    },
                    isNumber: true,
                    validator: (input){
                      if(requiredFieldValidator(input) != null){
                        return requiredFieldValidator(input);
                      }
                      try{
                        double.parse(input!.trim().replaceAll(',', ''));
                      }catch(exception){
                        return 'Invalid input, please enter a decimal number';
                      }
                    }
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: MaterialButton(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
                          child: Text(
                            'SAVE',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ),
                        onPressed: (){
                          formKey.currentState!.validate();
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  String? requiredFieldValidator(input){
    if(input == null || input.isEmpty) {
      return "this field is required";
    }
  }

  Widget getTextFormField({
    required String hint,
    required void Function(String) onChanged,
    required String? Function(String?) validator,
    bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          hint,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 15
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
              decoration:const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: onChanged,
              validator: validator,
              keyboardType: isNumber? const TextInputType.numberWithOptions(decimal: true, signed: false): TextInputType.name,
            ),
        ),

      ],
    );
  }
}
