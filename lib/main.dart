import 'package:admin_cebre/cielo_de_cebreros.dart';
import 'package:admin_cebre/presentation/booking/controller/booking_controller.dart';
import 'package:admin_cebre/presentation/contact/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactController()),
        ChangeNotifierProvider(create: (context) => BookingController()),
      ],

      
      child: const CieloDeCebreros(),
    )
  );
}

