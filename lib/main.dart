import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_engineer_interview/models/employee.dart';
import 'package:mobile_engineer_interview/screens/splash_page.dart';
import 'package:mobile_engineer_interview/providers/employee_list_provider.dart';

Future<void> main() async{
  /// setup hive box for employee storage access
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox('employees_box');
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  /// Builds and return a [MaterialApp]
  /// The [MaterialApp] is wrapped in a [ProviderScope] so that all providers can be accessed
  /// which in our case is [employeeListProvider]
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: GoogleFonts.montserrat().fontFamily
        ),
        home: const SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}