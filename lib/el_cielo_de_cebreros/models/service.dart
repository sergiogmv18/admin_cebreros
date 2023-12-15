import 'package:admin_cebre/model/model_base.dart';

class ServiceApp  extends ModelBase{
  String? name;
  String? photoBase64;
  ServiceApp({int? serverId, this.name, this.photoBase64}): super(serverId: serverId);

  //Gets
  String? getName(){
    return name;
  }

  String? getPhotoBase64(){
    return photoBase64;
  }


  //SETs
  void setName(String name){
    this.name = name;
  }
  
  void setPhotoBase64(String? photoBase64){
    this.photoBase64 = photoBase64;
  }

  // OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'serverId':serverId,
      'name':name,
      'photoId':photoBase64,
    };
  }
}
