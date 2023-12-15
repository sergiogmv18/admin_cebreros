import 'package:admin_cebre/cebreterra/controller/categories_cebreterra_controller.dart';
import 'package:admin_cebre/cebreterra/models/category_cebereterra.dart';
import 'package:admin_cebre/components/add_documents.dart';
import 'package:admin_cebre/components/alert.dart';
import 'package:admin_cebre/components/butom_custom.dart';
import 'package:admin_cebre/components/circular_loading.dart';
import 'package:admin_cebre/components/text_form_fields.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/controllers/services_controller.dart';
import 'package:admin_cebre/el_cielo_de_cebreros/models/service.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class RegisterServicesAppScreen extends StatefulWidget {
  final ServiceApp? serviceApp;
 const  RegisterServicesAppScreen({super.key, this.serviceApp});
  @override
  State<RegisterServicesAppScreen> createState() => _RegisterServicesAppScreenState();
}
class _RegisterServicesAppScreenState extends State<RegisterServicesAppScreen> {
  final formKey = GlobalKey<FormState>();
  ServiceApp serviceWk = ServiceApp();
  String extension = '';
  String? imgBase64;
  bool showBase64 = false;
  @override
  void initState() {
    if(widget.serviceApp != null){
      serviceWk = widget.serviceApp!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: formKey,
        child: Column(
          children:[
            TextFormFieldCustom(
              initialValue: serviceWk.getName() ?? '',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              labelText:'Nombre',
              validator: (text) {
                if (text!.trim().isEmpty) {
                  return 'please insert a valid value';
                }
                return null;
              },
              onChanged: (text) {
                if (text.trim().isEmpty) {
                  serviceWk.setName('');
                } else {
                  serviceWk.setName(text);
                }
              },
            ),
            const SizedBox(height: 20),
               FadeInUp(
              child:buttonCustom(
                context,
                title: 'Guardar',
                onPressed: () async{
                   List? photos = await addFilesPicker(context, returnValue: true);
                      if(photos != null && photos.isNotEmpty){
                        setState(() {
                          imgBase64 = photos[0]['base64String'];
                          extension = photos[0]['extension'];
                          showBase64 = true;
                        });
                        serviceWk.setPhotoBase64(imgBase64!);
                      }
                },
              )
            ),
           
            FadeInUp(
              child:buttonCustom(
                context,
                title: 'Guardar',
                onPressed: () async{
                  if (formKey.currentState!.validate()) {
                    showCircularLoadingDialog(context);
                    Map<String, dynamic>response = await ServicesAppController().registerOrEditService(serviceWk);
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
                  }
                },
              )
            ),
          ],
        )
      ),
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