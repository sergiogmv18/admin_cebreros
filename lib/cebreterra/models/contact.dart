import 'package:admin_cebre/model/model_base.dart';

class ContactCebreterra extends ModelBase{
  String? comments;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? status;
  ContactCebreterra ({int? serverId,this.status, this.comments, this.email, this.fullName, this.phoneNumber}): super(serverId: serverId);
    static const statusPending = 'pending';
    static const statusCheck = 'aprovated';
    static const statusAprovatedANDShow = 'aprovatedToShow';
  //Gets
  String? getComments(){
    return comments;
  }

  String? getFullName(){
    return fullName;
  }

  String? getPhoneNumber(){
    return phoneNumber;
  }

  String? getEmail(){
    return email;
  }

  String? getStatus(){
    return status;
  }

  //SETs
  void setComments(String? comments){
    this.comments = comments;
  }

  void setStatus(String? status){
    this.status = status;
  }

  void setPhoneNumber(String? phoneNumber){
    this.phoneNumber = phoneNumber;
  }

  void setFullName(String? fullName){
    this.fullName = fullName;
  }

  void setEmail(String? email){
    this.email = email;
  }

  // OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'serverId':serverId,
      'comments': comments,
      'email': email,
      'phoneNumber': phoneNumber,
      'fullName': fullName
    };
  }

   static allStatus(){
    return [
      'Todos', ContactCebreterra.statusAprovatedANDShow, ContactCebreterra.statusPending, ContactCebreterra.statusCheck
    ];

  }
}