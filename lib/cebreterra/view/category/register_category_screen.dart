import 'package:admin_cebre/cebreterra/controller/categories_cebreterra_controller.dart';
import 'package:admin_cebre/cebreterra/models/category_cebereterra.dart';
import 'package:admin_cebre/components/alert.dart';
import 'package:admin_cebre/components/butom_custom.dart';
import 'package:admin_cebre/components/circular_loading.dart';
import 'package:admin_cebre/components/text_form_fields.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class RegisterCategory extends StatefulWidget {
  final CategoryCebreterra? category;
 const  RegisterCategory({super.key, this.category});
  @override
  State<RegisterCategory> createState() => _RegisterCategoryState();
}
class _RegisterCategoryState extends State<RegisterCategory> {
  final formKey = GlobalKey<FormState>();
  CategoryCebreterra categoryWk = CategoryCebreterra();

  @override
  void initState() {
    if(widget.category != null){
      categoryWk = widget.category!;
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
              initialValue: categoryWk.getName() ?? '',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              labelText:'Nombre de categoria',
              validator: (text) {
                if (text!.trim().isEmpty) {
                  return 'please insert a valid value';
                }
                return null;
              },
              onChanged: (text) {
                if (text.trim().isEmpty) {
                  categoryWk.setName('');
                } else {
                  categoryWk.setName(text);
                }
              },
            ),
            const SizedBox(height: 20),
            FadeInUp(
              child:buttonCustom(
                context,
                title: 'Guardar',
                onPressed: () async{
                  if (formKey.currentState!.validate()) {
                    showCircularLoadingDialog(context);
                    Map<String, dynamic>response = await CategoryCebreterraController().registerOrEditCategory(categoryWk);
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
                      Navigator.of(context).pushNamedAndRemoveUntil('/cebreterra/categoria', (route) => false);
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


registerOrEditCategory(BuildContext context, {CategoryCebreterra? category})async{
  String title = category != null ? 'Editar categoria' : 'Nueva categoria'; 
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return AlertDialogCustom(
            title:title,
            content:RegisterCategory(category:category),
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