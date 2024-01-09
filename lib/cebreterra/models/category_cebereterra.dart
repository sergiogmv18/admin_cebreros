import 'package:admin_cebre/model/model_base.dart';

class CategoryCebreterra extends ModelBase{
  String? name;
  String? photoPath;
  CategoryCebreterra ({int? serverId,this.name, this.photoPath}): super(serverId: serverId);
  //Gets
  String? getName(){
    return name;
  }

  String? getPhotoPath(){
    return photoPath;
  }

  //SETs
  void setName(String? name){
    this.name = name;
  }

  void setPhotoPath(String? photoPath){
    this.photoPath = photoPath;
  }

  // OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'serverId':serverId,
      'comments': name,
      'photoPath':photoPath
    };
  }
}