import 'package:admin_cebre/components/app_bar_custom.dart';
import 'package:admin_cebre/components/buttom_menu.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HomeElCieloDeCebrerosScreen extends StatefulWidget {
  const HomeElCieloDeCebrerosScreen({super.key});
  @override
   HomeElCieloDeCebrerosScreenState createState() => HomeElCieloDeCebrerosScreenState();
}
class HomeElCieloDeCebrerosScreenState extends State<HomeElCieloDeCebrerosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, route: '/', changeLogo: 'elcielodecebreros', showButtonReturn: true),
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
                    buttonMenu(context, title: 'Reservas', route: '/el_cielo_de_cebreros/booking'),
                // BOOKING
                    buttonMenu(context, title: 'Servicios', route: '/el_cielo_de_cebreros/services'),
                //CONTACTO
                    buttonMenu(context, title: 'Preguntas o Halagos', route: '/el_cielo_de_cebreros/contact'),
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
