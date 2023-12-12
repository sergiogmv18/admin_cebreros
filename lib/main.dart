import 'package:admin_cebre/admin_cebre.dart';
import 'package:admin_cebre/cebreterra/controller/contact_cebreterra_controller.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/controllers/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactController()),
        ChangeNotifierProvider(create: (context) => ContactCebreterraController()),
      ],
      child: const AdminCebreApp(),
    )
  );
}

