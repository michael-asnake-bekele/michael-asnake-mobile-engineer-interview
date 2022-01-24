import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_engineer_interview/screens/employee_list_page.dart';

/// for displaying a splash screen page on the app's startup
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer timer = Timer(const Duration(seconds: 2),_goToHomePage);
  }
  /// navigates to home page
  _goToHomePage(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EmployeeListPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'S  A  M  A  S  Y  S',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white
                  ),
                ),
                Text(
                    'combat salary fraud',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    )
                ),
              ],
        ),
              const SizedBox(height: 32),
              const SpinKitSpinningLines(
                color: Colors.white,
              )
            ],
          ),

        ),
      ),
    );
  }
}
