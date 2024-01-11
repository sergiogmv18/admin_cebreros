import 'package:admin_cebre/cebreterra/controller/categories_cebreterra_controller.dart';
import 'package:admin_cebre/cebreterra/models/category_cebereterra.dart';
import 'package:admin_cebre/components/add_documents.dart';
import 'package:admin_cebre/components/alert.dart';
import 'package:admin_cebre/components/butom_custom.dart';
import 'package:admin_cebre/components/circular_loading.dart';
import 'package:admin_cebre/components/text_form_fields.dart';
import 'package:admin_cebre/helpers/functions_class.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterCategory extends StatefulWidget {
  final CategoryCebreterra? category;
 const  RegisterCategory({super.key, this.category});
  @override
  State<RegisterCategory> createState() => _RegisterCategoryState();
}
class _RegisterCategoryState extends State<RegisterCategory> {
  final formKey = GlobalKey<FormState>();
  CategoryCebreterra categoryWk = CategoryCebreterra();
  String? generatedNumber;
  String extension = '';
  String? imgBase64;
  bool showBase64 = false;
  Map? dataOfImg;
  String? oldNameFile;

  @override
  void initState() {
    if(widget.category != null){
      categoryWk = widget.category!;
      oldNameFile = categoryWk.getPhotoPath();
    }
    generatedNumber = FunctionClass().generateRandomNumber(); 
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
              title: 'adicionar imagen',
              onPressed: () async{
                List? photos = await addFilesPicker(context, returnValue: true);
                if(photos != null && photos.isNotEmpty){
                  setState(() {
                    imgBase64 = photos[0]['base64String'];
                    extension = photos[0]['extension'];
                    dataOfImg = photos[0];
                    dataOfImg!['nameFile'] = generatedNumber;
                    showBase64 = true;
                  });
                  categoryWk.setPhotoPath(imgBase64!);
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
                        'https://cebreterra.com/storade/categories/${categoryWk.getPhotoPath()}',
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
                      categoryWk.setPhotoPath(imgBase64);

                    });
                    
                  }, 
                  icon: FaIcon(FontAwesomeIcons.trash, size: 30, color: CustomColors.cancelActionButtonColor)
                )
              ],
            ),
          ]else...[
            if(categoryWk.getPhotoPath() != null)...[
              const SizedBox(height: 20),
              ClipRRect(  
                borderRadius:const BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  'https://cebreterra.com/storade/categories/${categoryWk.getPhotoPath()!}',
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
                    categoryWk.setPhotoPath(null);
                  });
                }, 
                icon: FaIcon(FontAwesomeIcons.trash, size: 30, color: CustomColors.cancelActionButtonColor)
              )
            ]
          ],
            const SizedBox(height: 20),
            FadeInUp(
              child:buttonCustom(
                context,
                title: 'Guardar',
                onPressed: () async{
                  if (formKey.currentState!.validate() && categoryWk.getPhotoPath() != null) {
                    showCircularLoadingDialog(context);
                    Map<String, dynamic>response = await CategoryCebreterraController().registerOrEditCategory(categoryWk, dataOfImg: dataOfImg, oldNameFile:oldNameFile);
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
            content:StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return RegisterCategory(category:category); 
            }),
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