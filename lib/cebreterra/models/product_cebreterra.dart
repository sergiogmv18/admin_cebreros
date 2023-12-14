import 'dart:convert';

import 'package:admin_cebre/model/model_base.dart';

class ProductCebreterra extends ModelBase{
  String? name;
  String? description;
  String? photosPath;
  int? categoryId;
  String? status;
  String? price;
  ProductCebreterra ({int? serverId,this.name, this.description, this.photosPath, this.categoryId, this.status, this.price}): super(serverId: serverId);
  //Gets
  String? getName(){
    return name;
  }

  String? getDescription(){
    return description;
  }

  List? getPhotosPath(){
    return photosPath != null ? json.decode(photosPath!) : [];
  }

  int? getCategoryId(){
    return categoryId;
  }
  String? getStatus(){
    return status;
  }

  String? getPrice(){
    return price;
  }

  //SETs
  void setName(String? name){
    this.name = name;
  }

  void setDescription(String? description){
    this.description = description;
  }

  void setPhotosPath(List? photosPath){
    this.photosPath = photosPath != null ? json.encode(photosPath) : json.encode([]);
  }

  void setCategoryId(int? categoryId){
    this.categoryId = categoryId;
  }

  void setStatus(String? status){
    this.status = status;
  }
  
  setPrice(String? price){
    this.price = price;
  }

  // OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'serverId':serverId,
      'name': name,
      'description':description,
      'categoryId':categoryId,
      'photos': photosPath,
      'status': status,
      'price':price
    };
  }
}