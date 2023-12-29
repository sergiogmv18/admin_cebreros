import 'dart:convert';
import 'package:admin_cebre/cebreterra/controller/categories_cebreterra_controller.dart';
import 'package:admin_cebre/cebreterra/controller/product_cebreterra_controller.dart';
import 'package:admin_cebre/cebreterra/models/category_cebereterra.dart';
import 'package:admin_cebre/cebreterra/models/product_cebreterra.dart';
import 'package:admin_cebre/components/add_documents.dart';
import 'package:admin_cebre/components/alert.dart';
import 'package:admin_cebre/components/app_bar_custom.dart';
import 'package:admin_cebre/components/butom_custom.dart';
import 'package:admin_cebre/components/circular_loading.dart';
import 'package:admin_cebre/components/text_form_fields.dart';
import 'package:admin_cebre/helpers/functions_class.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductInsertScreen extends StatefulWidget {
  final Map? data;
  const ProductInsertScreen({super.key,  this.data});
  @override
   ProductInsertScreenState createState() => ProductInsertScreenState();
}
class ProductInsertScreenState extends State<ProductInsertScreen> {
  ProductCebreterra productCebreterraWk = ProductCebreterra();
  bool edit = false;
  bool showProccessLoad = true;
  final formKey = GlobalKey<FormState>();
  List<CategoryCebreterra>? allCategories = [];
  CategoryCebreterra? categoryCebreterraSelected;
  List allPhotos = [];
    @override
  void initState() {
    initialSetup();
    super.initState();
  }

  /*
  * Initial setup
  * @author  SGV
  * @version 1.0 - 20211210 - initial release
  * @return  void
  */
  Future<void> initialSetup() async {
    allCategories = await CategoryCebreterraController().getAllCategories();
    setState(() {
      showProccessLoad = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, route: '/cebreterra/products', changeLogo: 'cebreterra', showButtonReturn: true),
      backgroundColor: CustomColors.frontColor,
      body:showProccessLoad? circularProgressIndicator(context): Container(
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
                 !edit? "Nuevo producto": 'Editar producto',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: formKey,
                child:Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
// NAME 
                         TextFormFieldCustom(
                          initialValue: productCebreterraWk.getName() ?? '',
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
                              productCebreterraWk.setName(null);
                            } else {
                              productCebreterraWk.setName(text);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
// DESCRIPTION
                        TextFormFieldCustom(
                          initialValue: productCebreterraWk.getDescription() ?? '',
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          labelText:'Descipción',
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              return 'please insert a valid value';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            if (text.trim().isEmpty) {
                              productCebreterraWk.setDescription(null);
                            } else {
                              productCebreterraWk.setDescription(text);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
// Categories
                        if(allCategories != null && allCategories!.isNotEmpty)...[
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
                            child: DropdownButton<CategoryCebreterra>(
                              value:categoryCebreterraSelected ?? allCategories![0],
                              underline: Container(),
                              onChanged: (CategoryCebreterra? newValue) {
                                if(newValue != null){
                                  setState(() {
                                    categoryCebreterraSelected = newValue;
                                    productCebreterraWk.setCategoryId(newValue.getServerId()); 
                                  });
                                 
                                }
                              },
                              items:allCategories!.map<DropdownMenuItem<CategoryCebreterra>>((CategoryCebreterra value) {
                                return DropdownMenuItem<CategoryCebreterra>(
                                  value: value,
                                  child: SizedBox(
                                    width:MediaQuery.of(context).size.width * 0.76,
                                    child: Text(
                                      value.getName()!,
                                      style:  Theme.of(context).textTheme.titleMedium,
                                      textAlign: TextAlign.start
                                    )
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
// PRICE
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          initialValue: productCebreterraWk.getPrice() ?? '',
                          textInputAction: TextInputAction.done,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          labelText:'precio',
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              return 'please insert a valid value';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            if (text.trim().isEmpty) {
                              productCebreterraWk.setPrice(null);
                            } else {
                              productCebreterraWk.setPrice(text);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          initialValue: productCebreterraWk.getHeight() ?? '',
                          textInputAction: TextInputAction.done,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          labelText:'altura',
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              return 'please insert a valid value';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            if (text.trim().isEmpty) {
                              productCebreterraWk.setheigh(null);
                            } else {
                              productCebreterraWk.setheigh(text);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          initialValue: productCebreterraWk.getWidth() ?? '',
                          textInputAction: TextInputAction.done,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          labelText:'anchura',
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              return 'please insert a valid value';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            if (text.trim().isEmpty) {
                              productCebreterraWk.setWidth(null);
                            } else {
                              productCebreterraWk.setWidth(text);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          initialValue: productCebreterraWk.getWeight() ?? '',
                          textInputAction: TextInputAction.done,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          labelText:'Peso',
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              return 'please insert a valid value';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            if (text.trim().isEmpty) {
                              productCebreterraWk.setWeight(null);
                            } else {
                              productCebreterraWk.setWeight(text);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          onPressed: () async{
                            List? photos = await addFilesPicker(context, returnValue: true,allowMultiple: true);
                            if(photos != null && photos.isNotEmpty){
                              if(allPhotos.isNotEmpty){
                                for(Map specificPhoto in photos){
                                 bool isAlreadySaved = ProductCebreterraController.checkAndSave(base64String:specificPhoto['base64String'], list:allPhotos);
                                    if(!isAlreadySaved){
                                      String generatedNamePhoto = FunctionClass().generateRandomNumber(); 
                                      specificPhoto['nameFile'] = generatedNamePhoto;
                                      setState(() {
                                        allPhotos.add({'nameFile':specificPhoto['nameFile'],'extension':specificPhoto['extension'], 'imgBase64':specificPhoto['base64String']},);
                                //  imgBase64 = photos[0]['base64String'];
                                //  extension = photos[0]['extension'];
                                //  dataOfImg = photos[0];
                                //  showBase64 = true;
                                    });
                                  }  
                                }
                              }else{
                                for(Map specificPhoto in photos){
                                  String generatedNamePhoto = FunctionClass().generateRandomNumber(); 
                                  specificPhoto['nameFile'] = generatedNamePhoto;
                                  setState(() {
                                   allPhotos.add({ 'nameFile':specificPhoto['nameFile'],'extension':specificPhoto['extension'],'imgBase64':specificPhoto['base64String']});
                                //  imgBase64 = photos[0]['base64String'];
                                //  extension = photos[0]['extension'];
                                //  dataOfImg = photos[0];
                                //  showBase64 = true;
                                  });
                                }
                              }   
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.camera),
                          color: CustomColors.activeButtonColor,
                          iconSize: 40,
                        ),
                        
                        Container(
                          height:allPhotos.isEmpty ? 0 : 200,
                          child: SingleChildScrollView(
                            scrollDirection:Axis.horizontal,
                            child: Row(
                              children: [
                                for(int photo = 0; photo < allPhotos.length; photo ++)...[
                                  Container(
                                   padding: const EdgeInsets.only(left: 10, right: 10),
                                    child:Column(
                                      children: [
                                        Image.memory(
                                          showContainerImg(allPhotos[photo]['imgBase64']),
                                          height: 140,
                                          fit: BoxFit.fitHeight, 
                                        ),
                                        IconButton(
                                        onPressed: () async{
                                          setState(() {
                                             allPhotos.removeAt(photo);
                                          });
                                        },
                                        icon: const FaIcon(FontAwesomeIcons.trash),
                                        color: CustomColors.cancelActionButtonColor,
                                        iconSize: 40,
                                      ),
                                      ],
                                    ) 
                                  )
                                ]
                              ]
                            ),
                          ),
                        ),


                        if(allPhotos.isNotEmpty)...[
                          if(edit)...[

                          ]else...[
                         
                          ]

                        ],
                        const SizedBox(height: 20),
                        FadeInUp(
                          child:buttonCustom(
                            context,
                            title: 'Guardar',
                            onPressed: () async{
                              if (formKey.currentState!.validate() && allPhotos.isNotEmpty) {
                                productCebreterraWk.setPhotosPath(allPhotos);
                                showCircularLoadingDialog(context);
                                Map<String, dynamic>response = await ProductCebreterraController().registerOrEditProducts(productCebreterraWk);
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
                                  Navigator.of(context).pushNamedAndRemoveUntil('/cebreterra/products', (route) => false);
                              }
                            },
                          )
                        ),
                      ],
                    ),
                  ),
                ) 
              ),        
            ],
          ),
        ),
      );
    }

/*
 * Convert base64 to bytes and return or value for show imagen of event
 * @author  SGV             - 20231019
 * @version 1.0             - 20231019 - initial release
 * @param   <String>  - img  - image in format base64                                               
 * @return  <widget>  widget 
 */
  showContainerImg(String img){
    Uint8List bytes = base64Decode(img);
    return bytes;
  }
  }
