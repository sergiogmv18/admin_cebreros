import 'package:admin_cebre/ui/app_bar_custom.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class RegisterBookingScreen extends StatefulWidget {
  const RegisterBookingScreen({super.key});
  @override
   RegisterBookingScreenState createState() => RegisterBookingScreenState();
}
class RegisterBookingScreenState extends State<RegisterBookingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, route: '/', changeLogo: 'elcielodecebreros', showButtonReturn: true),
      backgroundColor: CustomColors.frontColor,
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            FadeInLeft(
              duration: const Duration(milliseconds: 1500),
              child:Text(
                "Nueva reserva",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
