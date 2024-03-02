import 'package:admin_cebre/domain/entities/model_base.dart';

class ServiceApp  extends ModelBase{
  String? nameFile;
  String? photoBase64;
  ServiceApp({int? serverId, this.nameFile, this.photoBase64}): super(serverId: serverId);

  //Gets
  String? getNameFile(){
    return nameFile;
  }

  String? getPhotoBase64(){
    return photoBase64;
  }


  //SETs
  void setName(String nameFile){
    this.nameFile = nameFile;
  }
  
  void setPhotoBase64(String? photoBase64){
    this.photoBase64 = photoBase64;
  }

  // OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'serverId':serverId,
      'nameFile':nameFile,
      'photoId':photoBase64,
    };
  }
}
