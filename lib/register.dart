import 'package:flutter/material.dart';
import 'login_page.dart';

class NarsatApp extends StatelessWidget {
  const NarsatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نارسات',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        fontFamily:
            'Vazir', // اطمینان حاصل کنید که فونت وزیر را به پروژه اضافه کرده‌اید
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade200, width: 1.0),
            borderRadius: BorderRadius.circular(32.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 2.0),
            borderRadius: BorderRadius.circular(32.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(32.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(32.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
        ),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      // برای راست‌چین کردن کل برنامه
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}
