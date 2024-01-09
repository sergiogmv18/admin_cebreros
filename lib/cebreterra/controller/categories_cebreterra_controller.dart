import 'package:admin_cebre/cebreterra/models/category_cebereterra.dart';
import 'package:admin_cebre/services/request.dart';

class CategoryCebreterraController{

  
 /*
  * Convert json of server to Obj Services
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <List>
  */
  Future<List<CategoryCebreterra>> convertStringInObjCategories({required List data})async{
    List<CategoryCebreterra> allCategories = [];
    if(data.isNotEmpty){
      for(int c = 0; c < data.length; c++){
        CategoryCebreterra categoryWk = CategoryCebreterra(serverId:int.parse(data[c][0].toString()), name:data[c][1].toString(), photoPath:data[c][2].toString());
        allCategories.add(categoryWk);
      }
    }
    return allCategories;
  }  


  /*
  * get all Categories
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  all event saved
  */
  Future<List<CategoryCebreterra>> getAllCategories() async{
    List<CategoryCebreterra> allContacts = [];
    Map<String, dynamic> parameters = {
      'action': 'getAllCategories',
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
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverCebreterra);
    return response['success'];
  } 



/*
  * Register Category
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<Map<String, dynamic>> registerOrEditCategory(CategoryCebreterra categoryCebreterra, {Map? dataOfImg})async{
    Map<String, dynamic> response = {};
    Map<String, dynamic> parameters = {
      'action':'registerOrEditCategory',
      'name': categoryCebreterra.getName(),
      'imgBase64':categoryCebreterra.getPhotoPath(),
    };

    if(categoryCebreterra.getServerId() != null){
      parameters['id'] = categoryCebreterra.getServerId().toString();
    }
    if(dataOfImg != null){
      parameters['imgBase64New'] = dataOfImg['base64String'];
      parameters['extension'] = dataOfImg['extension'];
      parameters['nameFile'] = dataOfImg['nameFile'];
      parameters['isEditPhoto'] = 'true';
    }
    response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverCebreterra);
    return response;
  }


  Future getSpecificCategory(int serverId)async{
    List allCategories = await getAllCategories();
    for(CategoryCebreterra category in allCategories){
      if(category.getServerId() == serverId){
        return category;
      }
    }
  }
}