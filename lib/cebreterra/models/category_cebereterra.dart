import 'package:admin_cebre/model/model_base.dart';

class CategoryCebreterra extends ModelBase{
  String? name;
  CategoryCebreterra ({int? serverId,this.name}): super(serverId: serverId);
  //Gets
  String? getName(){
    return name;
  }

  //SETs
  void setName(String? name){
    this.name = name;
  }

  // OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'serverId':serverId,
      'comments': name,
    };
  }
}