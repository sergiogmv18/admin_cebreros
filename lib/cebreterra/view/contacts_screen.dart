import 'package:admin_cebre/cebreterra/controller/contact_cebreterra_controller.dart';
import 'package:admin_cebre/cebreterra/models/contact.dart';
import 'package:admin_cebre/components/alert.dart';
import 'package:admin_cebre/components/app_bar_custom.dart';
import 'package:admin_cebre/components/circular_loading.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ContactCebreterraScreen extends StatefulWidget {
  const ContactCebreterraScreen({super.key});
  @override
   ContactCebreterraScreenState createState() => ContactCebreterraScreenState();
}
class ContactCebreterraScreenState extends State<ContactCebreterraScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      var selectionModel = Provider.of<ContactCebreterraController>(context);
    return Scaffold(
      appBar: appBarCustom(context, route: '/cebreterra/home', changeLogo: 'cebreterra', showButtonReturn: true),
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
                  "Preguntas o Alagos",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
               const SizedBox(height: 20),
               Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10), 
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: CustomColors.frontColor,
                     borderRadius: BorderRadius.circular(12), // Border radius de 20
                  border: Border.all(
                    color: CustomColors.backgroundColorDark, // Color del borde
                    width: 1.0, // Ancho del borde
                  ),
                ),
                child: DropdownButton<String>(
                  value: selectionModel.searchStatus,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    if(newValue != null){
                      selectionModel.updateSelectedOption(newValue);  
                    }
                  },
                  items: ContactCebreterra.allStatus().map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: SizedBox(
                        width:MediaQuery.of(context).size.width * 0.76,
                        child: Text(
                          showTranslateOfStatus(value),
                          style:  Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.start
                        )
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future:selectionModel.searchStatus == ContactCebreterra.allStatus()[0] ?ContactCebreterraController().getAll() : ContactCebreterraController().getAllContactForStatus(selectionModel.searchStatus),
                    builder: (context, app){
                      if(app.connectionState == ConnectionState.done){
                        List? allContacts = app.data;
                        if(allContacts != null && allContacts.isNotEmpty){
                          return Wrap(
                           // spacing: 20,
                            runSpacing: 20,
                            children:List.generate(allContacts.length, (index){
                              return  FadeInUp(
                                duration: const Duration(milliseconds: 1500),
                                child:  Card(
                                  elevation: 4.0, // Elevación del Card
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12), // Border radius de 20
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
                                        SelectableText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:'Comentario: ',
                                                  style:  Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text:allContacts[index].getComments() ?? 'Comentario',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                            ]
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              child: Text('ver mas',
                                                style:Theme.of(context).textTheme.titleMedium!.copyWith( 
                                                  decorationColor: Colors.black,         // Color del subrayado
                                                  decorationThickness: 1.5,decoration: TextDecoration.underline,
                                                ),
                                              ),
                                              onPressed: ()async{
                                                showDetailsOfDoubts(allContacts[index]);
                                              },
                                            ),
                                            IconButton(
                                              onPressed: ()async{
                                               showCircularLoadingDialog(context);
                                                await ContactCebreterraController().deleteSpecificContact(allContacts[index]);
                                                Navigator.of(context).pushNamedAndRemoveUntil('/cebreterra/contact', (route) => false);
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
                          }
                        )
                      );
                    }
                    return Text(
                      'No hay dudas ni comentarios de los usuarios',
                      style: Theme.of(context).textTheme.titleMedium,
                    
                    );
                    }
                    return circularProgressIndicator(context);
                  }
                ),
            
                ) 
              ),
            ],
          ),
        ),
      );
    }

  showTranslateOfStatus(String status){
    switch(status){
      case ContactCebreterra.statusAprovatedANDShow:
      return 'Aprovados y mostrados';
      case ContactCebreterra.statusCheck:
      return 'Respondido';
      case ContactCebreterra.statusPending:
      return 'Pendientes';
      default: 
      return 'Todos';
    }
  }


  showDetailsOfDoubts(ContactCebreterra doubts)async{
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
                      showTranslateOfStatus(ContactCebreterra.statusAprovatedANDShow),
                      style:Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value: ContactCebreterra.statusAprovatedANDShow,
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(showTranslateOfStatus( ContactCebreterra.statusCheck),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value: ContactCebreterra.statusCheck,
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title:Text(showTranslateOfStatus( ContactCebreterra.statusPending),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value:ContactCebreterra.statusPending,
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
                          Map<String, dynamic>response = await ContactCebreterraController().registerOrEditContact(doubts);
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
