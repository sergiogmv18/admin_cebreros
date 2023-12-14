import 'package:admin_cebre/cebreterra/models/category_cebereterra.dart';
import 'package:admin_cebre/services/request.dart';

class ProductCebreterraController{

  
 /*
  * Convert json of server to Obj Services
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <List>
  */
  Future<List> convertStringInObjCategories({required List data})async{
    List allCategories = [];
    if(data.isNotEmpty){
      for(int c = 0; c < data.length; c++){
        CategoryCebreterra categoryWk = CategoryCebreterra(serverId:int.parse(data[c][0].toString()), name:data[c][1].toString());
        allCategories.add(categoryWk);
      }
    }
    return allCategories;
  }  


  /*
  * get all product
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  all event saved
  */
  Future<List> getAllProduct() async{
    List allContacts = [];
    Map<String, dynamic> parameters = {
      'action': 'getAllProduct',
    };
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters, server: RequestHttp.serverCebreterra);
    if(response['success']){
      allContacts = await convertStringInObjCategories(data: response['payload']);
    }
    return allContacts;
  }


 /*
  * Delete Contact
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<bool>deleteSpecificCategory(CategoryCebreterra category)async{
    Map<String, dynamic> parameters = {
      'action': 'deleteCategory',
      'id': category.getServerId().toString(),
    };
        print(parameters);
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverCebreterra);
    print(response);
    return response['success'];
  } 



/*
  * Register Category
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<Map<String, dynamic>> registerOrEditCategory(CategoryCebreterra categoryCebreterra)async{
    Map<String, dynamic> response = {};
    Map<String, dynamic> parameters = {
      'action':'registerOrEditCategory',
      'name': categoryCebreterra.getName(),
    };

    if(categoryCebreterra.getServerId() != null){
      parameters['id'] = categoryCebreterra.getServerId().toString();
    }
    response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverCebreterra);
    return response;
  }

}