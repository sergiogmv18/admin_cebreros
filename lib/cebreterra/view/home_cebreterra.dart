import 'package:admin_cebre/components/app_bar_custom.dart';
import 'package:admin_cebre/components/buttom_menu.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HomeCebreterraScreen extends StatefulWidget {
  const HomeCebreterraScreen({super.key});
  @override
   HomeCebreterraScreenState createState() =>HomeCebreterraScreenState();
}
class HomeCebreterraScreenState extends State<HomeCebreterraScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, route: '/', changeLogo: 'cebreterra', showButtonReturn: true),
      body:Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
            FadeInLeft(
              duration: const Duration(milliseconds: 1500),
              child:Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child:Text(
                  "Administrador del Cebreterra!",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
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
              //CONTACTO
                  buttonMenu(context, title: 'Preguntas o Alagos', route: '/cebreterra/contact'),
              // BOOKING
                  buttonMenu(context, title: 'Productos', route: '/cebreterra/products', width: MediaQuery.of(context).size.width*0.37),
              // Product    
                  buttonMenu(context, title: 'Categorias', route: '/cebreterra/categoria'),
                ],
              ),
            ) 
          ),
        ],
      ),
    );
  }


}
