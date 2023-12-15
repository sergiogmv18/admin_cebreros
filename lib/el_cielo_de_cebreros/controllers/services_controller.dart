import 'package:admin_cebre/el_cielo_de_cebreros/models/service.dart';
import 'package:admin_cebre/services/request.dart';

class ServicesAppController{



  /*
  * Register Services
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<Map<String, dynamic>> registerOrEditService(ServiceApp servicesWk)async{
    Map<String, dynamic> response = {};
    Map<String, dynamic> parameters = {
      'action':'registerOrEditServices',
      'name': servicesWk.getName(),
      'photo64': servicesWk.getPhotoBase64(),
    };

    if(servicesWk.getServerId() != null){
      parameters['id'] = servicesWk.getServerId().toString();
    }
    response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverElCieloDeCebreros);
    return response;
  }



  /*
  * get all Services
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  all event saved
  */
  Future<List> getAll() async{
    List allContacts = [];
    Map<String, dynamic> parameters = {
      'action': 'getAllServices',
    };
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters, server: RequestHttp.serverElCieloDeCebreros);
    if(response['success']){
      allContacts = await convertStringInObjService(data: response['payload']);
    }
    return allContacts;
  }


   /*
  * Convert json of server to Obj Services
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <List>
  */
  Future<List> convertStringInObjService({required List data})async{
    List allServices = [];
    if(data.isNotEmpty){
      for(int c = 0; c < data.length; c++){
        ServiceApp servicesWk = ServiceApp(serverId:int.parse(data[c][0].toString()), name:data[c][1].toString(), photoBase64:data[c][3].toString());
        allServices.add(servicesWk);
      }
    }
    return allServices;
  }  


 /*
  * Delete Contact
  * @author SGV
  * @version 1.0 - 20230215 - initial release
  * @return  <Map<String, dynamic>>
  */
  Future<bool>deleteSpecificServices(ServiceApp serviceWk)async{
     Map<String, dynamic> parameters = {
      'action': 'deleteServices',
      'id': serviceWk.getServerId().toString(),
    };
    Map<String, dynamic> response = await RequestHttp().httpPost(parameters: parameters,server: RequestHttp.serverElCieloDeCebreros);
    return response['success'];
  } 

}