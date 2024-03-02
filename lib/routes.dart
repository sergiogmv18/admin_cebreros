import 'package:admin_cebre/presentation/booking/screen/booking_screen.dart';
import 'package:admin_cebre/presentation/booking/screen/register_booking_screen.dart';
import 'package:admin_cebre/presentation/contact/screen/contact.dart';
import 'package:admin_cebre/presentation/home/screen/home_screen.dart';
import 'package:admin_cebre/presentation/services/services.dart';
import 'package:flutter/material.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/' : (BuildContext context) => const HomeScreen(),
  '/services' : (BuildContext context) => const ServicesAppScreen(),
  '/contact' : (BuildContext context) => const ContactScreen(),
  '/booking': (BuildContext context) => const BookingScreen(), 
  '/booking/create': (BuildContext context) => const RegisterBookingScreen(), 
};