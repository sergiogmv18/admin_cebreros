import 'package:admin_cebre/components/add_documents.dart';
import 'package:admin_cebre/components/alert.dart';
import 'package:admin_cebre/components/butom_custom.dart';
import 'package:admin_cebre/components/circular_loading.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/controllers/services_controller.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/models/service.dart';
import 'package:admin_cebre/helpers/functions_class.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterServicesAppScreen extends StatefulWidget {
  final ServiceApp? serviceApp;
 const  RegisterServicesAppScreen({super.key, this.serviceApp});
  @override
  State<RegisterServicesAppScreen> createState() => _RegisterServicesAppScreenState();
}
class _RegisterServicesAppScreenState extends State<RegisterServicesAppScreen> {
  ServiceApp serviceWk = ServiceApp();
  String extension = '';
  String? imgBase64;
  bool showBase64 = false;
  Map? dataOfImg;
  @override
  void initState() {
    if(widget.serviceApp != null){
      serviceWk = widget.serviceApp!;
    }
    String generatedNumber = FunctionClass().generateRandomNumber(); 
    serviceWk.setName(generatedNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children:[
          FadeInUp(
            child:buttonCustom(
              context,
              title: 'adicionar imagen',
              onPressed: () async{
                List? photos = await addFilesPicker(context, returnValue: true);
                if(photos != null && photos.isNotEmpty){
                  setState(() {
                    imgBase64 = photos[0]['base64String'];
                    extension = photos[0]['extension'];
                    dataOfImg = photos[0];
                    
                    showBase64 = true;
                  });
                  serviceWk.setPhotoBase64(imgBase64!);
                }
              },
            )
          ),
// Show selected img 
          if(imgBase64 != null)...[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                if(showBase64)...[
                    Image.memory(
                     FunctionClass.showContainerImg(imgBase64!), 
                      width:MediaQuery.of(context).size.width,   
                      fit: BoxFit.fitWidth, 
                    ),
                ]else...[
                  ClipRRect(  
                    borderRadius:const BorderRadius.only(topLeft: Radius.circular(12), topRight:  Radius.circular(12)),
                    child: Image.network(
                        'https://cielodecebreros.com/storade/services/${serviceWk.getPhotoBase64()}',
                      filterQuality:FilterQuality.high, 
                      width:MediaQuery.of(context).size.width,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/loading.gif', 
                          width:MediaQuery.of(context).size.width,
                          filterQuality:FilterQuality.high,
                          fit: BoxFit.fitWidth, 
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
                ],
                IconButton(
                  iconSize: 30,
                  onPressed:(){
                    setState(() {
                      imgBase64 = null;
                    });
                    
                  }, 
                  icon: FaIcon(FontAwesomeIcons.trash, size: 30, color: CustomColors.cancelActionButtonColor)
                )
              ],
            ),
          ]else...[
            if(serviceWk.getPhotoBase64() != null)...[
              ClipRRect(  
                borderRadius:const BorderRadius.only(topLeft: Radius.circular(12), topRight:  Radius.circular(12)),
                child: Image.network(
                  serviceWk.getPhotoBase64()!,
                  filterQuality:FilterQuality.high, 
                  width:MediaQuery.of(context).size.width,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/images/loading.gif', 
                      width:MediaQuery.of(context).size.width,
                      filterQuality:FilterQuality.high,
                      fit: BoxFit.fitWidth, 
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
              IconButton(
                iconSize: 30,
                onPressed:(){
                  setState(() {
                    serviceWk.setPhotoBase64(null);
                  });
                }, 
                icon: FaIcon(FontAwesomeIcons.trash, size: 30, color: CustomColors.cancelActionButtonColor)
              )
            ]
          ],
          const SizedBox(height: 30),
          if(imgBase64 != null)...[
            FadeInUp(
              child:buttonCustom(
                context,
                title: 'Guardar',
                onPressed: () async{
                  showCircularLoadingDialog(context);
                  Map<String, dynamic>response = await ServicesAppController().registerOrEditService(serviceWk, isEditPhoto: showBase64, dataOfImg: dataOfImg);
                  if(response['success'] == false){
                    Navigator.of(context).pop();
                    showMessageErrorServer(context, 
                      errorServer:response['errorCode'], 
                      onPressed:(){
                        Navigator.of(context).pop();
                      }
                    );
                    return;
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil('/el_cielo_de_cebreros/services', (route) => false);
                },
              )
            ),
          ],
        ],
      )
    );
  }  
}


registerOrEditService(BuildContext context, {ServiceApp? serviceApp})async{
  String title = serviceApp != null ? 'Editar Servicio' : 'Nuevo Servicio'; 
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return AlertDialogCustom(
            title:title,
            content:RegisterServicesAppScreen(serviceApp:serviceApp),
             actions: [
              TextButton(
                onPressed:(){
                  Navigator.of(context).pop();
                }, 
                child:Text(
                  'Volver',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: CustomColors.activeButtonColor) 
                
                )
              )
            ],
          );
      }
  );

}