import 'package:admin_cebre/cebreterra/models/product_cebreterra.dart';
import 'package:admin_cebre/cebreterra/view/category/categories_screen.dart';
import 'package:admin_cebre/cebreterra/view/contacts_screen.dart';
import 'package:admin_cebre/cebreterra/view/home_cebreterra_screen.dart';
import 'package:admin_cebre/cebreterra/view/products/details_screen.dart';
import 'package:admin_cebre/cebreterra/view/products/product_register_screen.dart';
import 'package:admin_cebre/cebreterra/view/products/products_screen.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/views/contact.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/views/home_cebreros.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/views/services/services.dart';
import 'package:admin_cebre/home.dart';
import 'package:flutter/material.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/' : (BuildContext context) => const HomeScreen(),
  
// EL CIELO DE CEBREROS
  '/el_cielo_de_cebreros/home' :(BuildContext context) => const HomeElCieloDeCebrerosScreen(),
 '/el_cielo_de_cebreros/contact':(BuildContext context) => const ContactElCieloDeCebrerosScreen(),
 '/el_cielo_de_cebreros/services':(BuildContext context) => const ServicesElCieloDeCebrerosScreen(),
 ///el_cielo_de_cebreros/booking
 
// CEBRETERRA
  '/cebreterra/home' : (BuildContext context) => const HomeCebreterraScreen(),
  '/cebreterra/contact': (BuildContext context) => const ContactCebreterraScreen(),
  '/cebreterra/products': (BuildContext context) => const ProductsScreen(),
  '/cebreterra/categoria': (BuildContext context) => const CategoryebreterraScreen(),
  'cebreterra/register/product' : (BuildContext context) => ProductInsertScreen( data: ModalRoute.of(context)!.settings.arguments as Map?),  
  'cebreterra/details/product': (BuildContext context) => ProductDetailsScreen( productWk: ModalRoute.of(context)!.settings.arguments as ProductCebreterra),  
  //'/login':(BuildContext context) => LoginScreen(data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?), 
  //'/form/data/finalUser' : (BuildContext context) => FormDataFinalUserScreen( data: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?), 
};