import 'package:admin_cebre/cebreterra/view/categories.dart';
import 'package:admin_cebre/cebreterra/view/contacts.dart';
import 'package:admin_cebre/cebreterra/view/home_cebreterra.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/views/contact.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/views/home_cebreros.dart';
import 'package:admin_cebre/home.dart';
import 'package:flutter/material.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/' : (BuildContext context) => HomeScreen(),
  
// EL CIELO DE CEBREROS
  '/el_cielo_de_cebreros/home' :(BuildContext context) => const HomeElCieloDeCebrerosScreen(),
 '/el_cielo_de_cebreros/contact':(BuildContext context) => const ContactElCieloDeCebrerosScreen(),
 ///el_cielo_de_cebreros/booking
 
// CEBRETERRA
  '/cebreterra/home' : (BuildContext context) => const HomeCebreterraScreen(),
  '/cebreterra/contact': (BuildContext context) => const ContactCebreterraScreen(),
  '/cebreterra/products': (BuildContext context) => const HomeCebreterraScreen(),
  '/cebreterra/categoria': (BuildContext context) => const CategoryebreterraScreen(),
  //'/home' : (BuildContext context) => HomeScreen( index: ModalRoute.of(context)!.settings.arguments as int?),  
  //'/login':(BuildContext context) => LoginScreen(data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?), 
  //'/form/data/finalUser' : (BuildContext context) => FormDataFinalUserScreen( data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?), 
};