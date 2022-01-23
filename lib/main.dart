import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/screens/employee_list_page.dart';

Future<void> main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox('employees_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: GoogleFonts.montserrat().fontFamily
        ),
        home: const EmployeeListPage(),
        debugShowCheckedModeBanner: false,

      ),
    );
  }
}