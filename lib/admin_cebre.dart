import 'package:admin_cebre/routes.dart';
import 'package:admin_cebre/style.dart';
import 'package:flutter/material.dart';

class AdminCebreApp extends StatelessWidget {
  const AdminCebreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Cebre',
      theme: CebrerosStyle().theme,
      routes: routes,
    );
  }
}