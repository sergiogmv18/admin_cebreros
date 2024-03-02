import 'package:admin_cebre/routes.dart';
import 'package:admin_cebre/style.dart';
import 'package:flutter/material.dart';

class CieloDeCebreros extends StatelessWidget {
  const CieloDeCebreros({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cielo de cebreros',
      theme: CebrerosStyle().theme,
      routes: routes,
    );
  }
}