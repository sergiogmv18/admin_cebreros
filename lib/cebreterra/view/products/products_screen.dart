import 'package:admin_cebre/cebreterra/controller/product_cebreterra_controller.dart';
import 'package:admin_cebre/cebreterra/models/product_cebreterra.dart';
import 'package:admin_cebre/components/alert.dart';
import 'package:admin_cebre/components/app_bar_custom.dart';
import 'package:admin_cebre/components/butom_custom.dart';
import 'package:admin_cebre/components/circular_loading.dart';
import 'package:admin_cebre/style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, route: '/cebreterra/home', changeLogo: 'cebreterra', showButtonReturn: true),
      backgroundColor: CustomColors.frontColor,
      floatingActionButton: IconButton(
        onPressed: ()async{
          Navigator.of(context).pushNamedAndRemoveUntil('cebreterra/register/product', (route) => false);    
        }, 
        icon:const FaIcon(FontAwesomeIcons.circlePlus),
        color:  CustomColors.pantone5615,
        iconSize: 50,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
           children: [
              const SizedBox(height: 20),
              FadeInLeft(
                duration: const Duration(milliseconds: 1500),
                child:Text(
                  "Productos",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future:ProductCebreterraController().getAllProduct(),
                    builder: (context, app){
                      if(app.connectionState == ConnectionState.done){
                        List? allProduct = app.data;
                        if(allProduct != null && allProduct.isNotEmpty){
                          return Column(
                            children:List.generate(allProduct.length, (index){
                              return  FadeInUp(
                                duration: Duration(seconds: 1+index),
                                child:Container(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child:Card(
                                    elevation: 4.0, // Elevación del Card
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), // Border radius de 20
                                      side: BorderSide(color:CustomColors.tableColor2, width: 2),
                                    ),
                                    color: CustomColors.tableColor,
                                    child: Container(
                                    // padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    //  transformAlignment: Alignment.center,
                                      width:MediaQuery.of(context).size.width,
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                              maxHeight:MediaQuery.of(context).size.width * 0.4, // Establece el alto máximo deseado
                                            ),
                                            width:MediaQuery.of(context).size.width * 0.4,
                                            child: ClipRRect(  
                                              borderRadius:const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft:  Radius.circular(12)),
                                              child: Image.network(
                                                'https://cebreterra.com/storade/product/${allProduct[index].getPhotosPath()[0]}',
                                                fit: BoxFit.fitWidth, 
                                                filterQuality:FilterQuality.high, 
                                                width: MediaQuery.of(context).size.width,
                                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                  return Image.asset('assets/images/loading.gif', 
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
                                          Container(
                                            width:MediaQuery.of(context).size.width * 0.47,
                                            padding: const EdgeInsets.only(left: 5, right: 5),
                                            child: Column(
                                              children: [
                                                Text(
                                                  allProduct[index].getName(),
                                                  style:  Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  allProduct[index].getDescription(),
                                                  style:  Theme.of(context).textTheme.titleMedium,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
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
                                                        Navigator.of(context).pushNamedAndRemoveUntil('cebreterra/details/product', (route) => false, arguments: allProduct[index]); 
                                                      },
                                                    ),
                                                    IconButton(
                                                      onPressed: ()async{
                                                        deleteProduct(context, productCebreterraWk:allProduct[index]);
                                                      },
                                                      icon: const FaIcon(FontAwesomeIcons.trash),
                                                      color: CustomColors.kSecondaryColor,
                                                      iconSize: 30,
                                                    ) 
                                                  ], 
                                                )
                                              
                                              ]
                                            ),
                                          ),
                                        
                                          
                                        ],
                                      )
                                    ),
                                  )
                                )
                              );
                          }
                        )
                      );
                    }
                    return Text(
                      'No se a registrado un Producto',
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

/*
 * Delete Product
 * @author  SGV             - 20231019
 * @version 1.0             - 20231019 - initial release                                             
 * @return  <ProductCebreterra>  product to deleted 
 */
deleteProduct(BuildContext context, {required ProductCebreterra productCebreterraWk})async{
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialogCustom(
        title:'Atencion',
        content:Text(
          'Desea eliminar este producto?',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        actions: [
          buttonCustom(
            context,
            title: 'No',
            onPressed: () {
                  Navigator.of(context).pop();
            },
            bacgroundColor: CustomColors.activeButtonColor 
          ),
          buttonCustom(
            context,
            title: 'Si',
            onPressed: ()async {
              showCircularLoadingDialog(context);
              Map<String, dynamic>response = await ProductCebreterraController().deleteProduct(productCebreterraWk);
              if(response['success'] == false){
                Navigator.of(context).pop();
                showMessageErrorServer(context, 
                  errorServer:response['errorCode'], 
                  onPressed:(){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                );
                return;
              }
                Navigator.of(context).pushNamedAndRemoveUntil('/cebreterra/products', (route) => false);

            },
            bacgroundColor: CustomColors.cancelActionButtonColor 
          )

        ],
      );
    }
  );
}
