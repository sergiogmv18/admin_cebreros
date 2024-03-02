import 'package:admin_cebre/ui/app_bar_custom.dart';
import 'package:admin_cebre/ui/buttom_menu.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
   HomeScreenState createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, changeLogo: 'elcielodecebreros', showButtonReturn: false),
      backgroundColor: CustomColors.frontColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
              FadeInLeft(
                duration: const Duration(milliseconds: 1500),
                child:Text(
                  "Administrador del Cielo de Cebreros!",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  alignment:WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment:WrapCrossAlignment.center,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                // BOOKING
                    buttonMenu(context, title: 'Reservas', route: '/booking'),
                // BOOKING
                    buttonMenu(context, title: 'Servicios', route: '/services'),
                //CONTACTO
                    buttonMenu(context, title: 'Preguntas o Halagos', route: '/contact'),
                  ],
                ),
              ) 
            ),
          ],
        ),
      ),
    );
  }


}
