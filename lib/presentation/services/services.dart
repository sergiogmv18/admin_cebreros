import 'package:admin_cebre/ui/alert.dart';
import 'package:admin_cebre/ui/app_bar_custom.dart';
import 'package:admin_cebre/presentation/contact/controller/contact_controller.dart';
import 'package:admin_cebre/presentation/services/controller/services_controller.dart';
import 'package:admin_cebre/domain/entities/contact.dart';
import 'package:admin_cebre/ui/circular_loading.dart';
import 'package:admin_cebre/presentation/services/register_services_screen.dart';
import 'package:admin_cebre/style.dart';
import 'package:admin_cebre/utils/helpers/functions_class.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ServicesAppScreen extends StatefulWidget {
  const ServicesAppScreen({super.key});
  @override
   ServicesAppScreenState createState() => ServicesAppScreenState();
}
class ServicesAppScreenState extends State<ServicesAppScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, route: '/', changeLogo: 'elcielodecebreros', showButtonReturn: true),
      backgroundColor: CustomColors.frontColor,
      floatingActionButton: IconButton(
        onPressed: ()async{
        registerOrEditService(context);
        }, 
        icon:const FaIcon(FontAwesomeIcons.circlePlus),
        color:  CustomColors.pantone5615,
        iconSize: 50,
      ),
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
                  "Servicios",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future:ServicesAppController().getAll(),
                builder: (context, app){
                  if(app.connectionState == ConnectionState.done){
                    List? allServices = app.data;
                    if(allServices != null && allServices.isNotEmpty){
                       return Expanded(
                        child:ListView.builder(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                          itemCount: allServices.length,
                          itemBuilder: (BuildContext context, int index) {
                            return  FadeInUp(
                              duration: Duration(seconds: (index)),
                              child:  Card(
                              elevation: 4.0, // Elevación del Card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(FunctionClass.borderRadius), // Border radius de 20
                                side: BorderSide(color:CustomColors.tableColor2, width: 2),
                              ),
                              color: CustomColors.tableColor,
                              child:Container(
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                transformAlignment: Alignment.center,
                                width:MediaQuery.of(context).size.width,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:MediaQuery.of(context).size.width,
                                      child: ClipRRect(  
                                        borderRadius:const BorderRadius.all(Radius.circular(FunctionClass.borderRadius)),
                                        child: Image.network(
                                          allServices[index].getPhotoBase64(),
                                          fit: BoxFit.fitWidth, 
                                          filterQuality:FilterQuality.high, 
                                          width: MediaQuery.of(context).size.width,
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return Image.asset('assets/Niblogo.PNG', 
                                              fit: BoxFit.fitWidth, 
                                              filterQuality:FilterQuality.high, 
                                            );
                                          },
                                          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                            return child;
                                          },
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child: circularProgressIndicator(context),
                                              );
                                            }
                                          }
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: ()async{
                                            showCircularLoadingDialog(context);
                                            await ServicesAppController().deleteSpecificServices(allServices[index]);
                                            Navigator.of(context).pushNamedAndRemoveUntil('/services', (route) => false);
                                          
                                          },
                                          icon: const FaIcon(FontAwesomeIcons.trash),
                                          color: CustomColors.kSecondaryColor,
                                          iconSize: 30,
                                        ) 
                                      ], 
                                    )
                                  ],
                                )
                              ),
                            )
                          );
                          },
                        ),
                       );




              
                }
                return Text(
                  'No hay dudas servicios registrados',
                  style: Theme.of(context).textTheme.titleMedium,
                
                );
                }
                return circularProgressIndicator(context);
              }
            ),
            ],
          ),
        ),
      );
    }

  showTranslateOfStatus(String status){
    switch(status){
      case Contact.statusAprovatedANDShow:
      return 'Aprovados y mostrados';
      case Contact.statusCheck:
      return 'Respondido';
      case Contact.statusPending:
      return 'Pendientes';
      default: 
      return 'Todos';
    }
  }


  showDetailsOfDoubts(Contact doubts)async{
    // buscar personId dele
    String? newStatus = doubts.getStatus()!;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return AlertDialogCustom(
            title:'Detalles',
            content:Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              transformAlignment: Alignment.center,
              //width:MediaQuery.of(context).size.width* 0.8,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                  SelectableText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Comentario: ',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                          
                        ),
                          TextSpan(
                          text:doubts.getComments(),
                          style:Theme.of(context).textTheme.titleSmall!  
                          
                        ),
                        const TextSpan(text: '\n\n'),
                        TextSpan(
                          text: 'Datos de Usuario: ',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                          
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: 'Nombre :',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                          
                        ),
                        TextSpan(
                          text:doubts.getFullName(),
                          style:  Theme.of(context).textTheme.titleSmall!  
                        
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: 'Numero de Telefono: ',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                          
                        ),
                        TextSpan(
                          text:doubts.getPhoneNumber(),
                          style: Theme.of(context).textTheme.titleSmall!  
                          
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: 'Correo electronico:',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                    
                        ),
                        TextSpan(
                          text:doubts.getEmail(),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                        )
                      ]
                    ),
                    textAlign: TextAlign.start,
                  ),
                  RadioListTile<String>(
                    title: Text(
                      showTranslateOfStatus(Contact.statusAprovatedANDShow),
                      style:Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value: Contact.statusAprovatedANDShow,
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(showTranslateOfStatus( Contact.statusCheck),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value: Contact.statusCheck,
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title:Text(showTranslateOfStatus( Contact.statusPending),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value:Contact.statusPending,
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                  if(newStatus != doubts.getStatus())...[
                    FadeInUp(
                      child:ElevatedButton(
                        onPressed: () async{
                          doubts.setStatus(newStatus);
                          showCircularLoadingDialog(context);
                          Map<String, dynamic>response = await ContactController().registerOrEditContact(doubts);
                          if(response['success'] == false){
                            Navigator.of(context).pop();
                            showMessageErrorServer(context,  errorServer:response['errorCode'],  onPressed:(){
                                Navigator.of(context).pop();
                              }
                            );
                            return;
                          }
                          Navigator.of(context).pushNamedAndRemoveUntil('/el_cielo_de_cebreros/contact', (route) => false); 
                        },
                        style: ElevatedButton.styleFrom(  
                          elevation: 6,
                          backgroundColor: CustomColors.pantone5615,// Color de fondo blanco
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Border radius de 20
                          ),
                        ),
                        child:Container(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                          child: Text(
                            'SALVAR',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: CustomColors.frontColor, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ]
                ]
              ), 
            ),
            actions: [
              TextButton(
                onPressed:(){
                  Navigator.of(context).pop();
                }, 
                child:Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: CustomColors.activeButtonColor) 
                
                )
              )
            ],
          );
        });
      }
    );
  }

}
