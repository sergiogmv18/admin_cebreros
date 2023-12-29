import 'dart:convert';
import 'package:admin_cebre/cebreterra/models/product_cebreterra.dart';
import 'package:admin_cebre/services/request.dart';

class ProductCebreterraController{

  
 /*
  * Convert json of server to Obj Product
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <List>
  */
  Future<List> convertStringInObjProduct({required List data})async{
    List allProductCebreterra = [];
    if(data.isNotEmpty){
      for(int c = 0; c < data.length; c++){
        ProductCebreterra productCebreterrayWk = ProductCebreterra(serverId:int.parse(data[c][0].toString()), name:data[c][1].toString(),description:data[c][2].toString(), photosPath:data[c][3].toString(), categoryId:int.parse(data[c][4].toString()), status:data[c][5].toString(), price: data[c][6].toString(), height: data[c][7].toString(), weight: data[c][8].toString(), width: data[c][9].toString(), comprission: data[c][10].toString());
        allProductCebreterra.add(productCebreterrayWk);   
      }
    }
    return allProductCebreterra;
  }  


  /*
  * get all product
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  all event saved
  */
  Future<List> getAllProduct() async{
    List allProductCebreterra = [];
    Map<String, dynamic> parameters = {
      'action': 'getAllProduct',
    };
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters, server: RequestHttp.serverCebreterra);
    if(response['success']){
      allProductCebreterra = await convertStringInObjProduct(data: response['payload']);
    }
     
    return allProductCebreterra;
  }


 /*
  * Delete Contact
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<Map<String, dynamic>> deleteProduct(ProductCebreterra productWk)async{
    Map<String, dynamic> parameters = {
      'action': 'deleteProduct',
      'id': productWk.getServerId().toString(),
      'photosPath':json.encode(productWk.getPhotosPath()),
    };
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverCebreterra);
    return response;
  } 



/*
  * Register Category
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<Map<String, dynamic>> registerOrEditProducts(ProductCebreterra productCebreterraWk)async{
    Map<String, dynamic> response = {};
    Map<String, dynamic> parameters = {
      'action':'registerOrEditProduct',
      'name': productCebreterraWk.getName().toString(),
      'description':productCebreterraWk.getDescription().toString(),
      'categoryId': productCebreterraWk.getCategoryId().toString(),
      'status': productCebreterraWk.getStatus() ?? '0' ,
      'price': productCebreterraWk.getPrice().toString(),
      'height': productCebreterraWk.getHeight().toString(),
      'weight': productCebreterraWk.getWeight().toString(),
      'width': productCebreterraWk.getWidth().toString(),
      'comprission': productCebreterraWk.getComprission()?? '0',
      'photosPath' : json.encode(productCebreterraWk.getPhotosPath()),
    };

    if(productCebreterraWk.getServerId() != null){
      parameters['id'] = productCebreterraWk.getServerId().toString();
    }
    response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverCebreterra);
    return response;
  }


  /*
  * Function to check and save the base64String if not already present
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <bool>
  */
  static bool checkAndSave({required String base64String, required List list}){
    bool isAlreadySaved = list.any((map) => map['base64String'] == base64String);
    return isAlreadySaved;
  }

}