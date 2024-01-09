import 'package:admin_cebre/cebreterra/controller/categories_cebreterra_controller.dart';
import 'package:admin_cebre/cebreterra/view/category/register_category_screen.dart';
import 'package:admin_cebre/components/app_bar_custom.dart';
import 'package:admin_cebre/components/circular_loading.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryebreterraScreen extends StatefulWidget {
  const CategoryebreterraScreen({super.key});
  @override
   CategoryebreterraScreenState createState() => CategoryebreterraScreenState();
}
class CategoryebreterraScreenState extends State<CategoryebreterraScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, route: '/cebreterra/home', changeLogo: 'cebreterra', showButtonReturn: true),
      backgroundColor: CustomColors.frontColor,
      floatingActionButton: IconButton(
        onPressed: ()async{
          registerOrEditCategory(context);
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
                  "Categorias",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future:CategoryCebreterraController().getAllCategories(),
                    builder: (context, app){
                      if(app.connectionState == ConnectionState.done){
                        List? allCategories = app.data;
                        if(allCategories != null && allCategories.isNotEmpty){
                          return Wrap(
                           // spacing: 20,
                            runSpacing: 20,
                            children:List.generate(allCategories.length, (index){
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
                                    child:Row(
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:MediaQuery.of(context).size.width * 0.3,
                                          child: ClipRRect(  
                                            borderRadius:const BorderRadius.only(topLeft: Radius.circular(12), topRight:  Radius.circular(12)),
                                            child: Image.network(
                                              allCategories[index].getPhotoPath() != null ? 'https://cebreterra.com/storade/categories/${allCategories[index].getPhotoPath()}' : '',
                                              filterQuality:FilterQuality.high, 
                                              width:MediaQuery.of(context).size.width,
                                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                return Image.asset(
                                                  'assets/images/banner.png', 
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
                                        ),
                                        SizedBox(
                                          width:MediaQuery.of(context).size.width * 0.51,
                                          child:Column(
                                            children: [
                                              Text(
                                                allCategories[index].getName(),
                                                style:  Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
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
                                                      registerOrEditCategory(context, category:allCategories[index]);
                                                    },
                                                  ),
                                                  IconButton(
                                                    onPressed: ()async{
                                                      showCircularLoadingDialog(context);
                                                      await CategoryCebreterraController().deleteSpecificCategory(allCategories[index]);
                                                      Navigator.of(context).pushNamedAndRemoveUntil('/cebreterra/categoria', (route) => false);
                                                    },
                                                    icon: const FaIcon(FontAwesomeIcons.trash),
                                                    color: CustomColors.kSecondaryColor,
                                                    iconSize: 30,
                                                  ) 
                                                ], 
                                              ),
                                            ],
                                          )
                                         ),
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
                      'No se a registrado una categoria para los productos',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    
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
}

