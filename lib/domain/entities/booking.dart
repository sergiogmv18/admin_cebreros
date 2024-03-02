import 'dart:convert';

import 'package:admin_cebre/domain/entities/model_base.dart';

class Booking  extends ModelBase{

  String? numberOfPerson;
  String? initialDate;
  String? finalDate;
  int? roomId;
  String? roomName;
  String? price;
  String? statusPayment;
  String? fullNameOfPerson;
  String? status;
  bool? typePayment;

  Booking ({int? serverId, this.typePayment = true, this.numberOfPerson, this.initialDate, this.finalDate, this.roomId, this.roomName, this.price, this.statusPayment, this.fullNameOfPerson, this.status}): super(serverId: serverId);
  static const completed = 0; // The reservation has concluded, and the planned stay has been fulfilled.
  static const pending = 1; //The reservation has been created but not yet confirmed or paid.
  static const confirmed = 2; //The reservation has been confirmed, either through payment or some other action indicating that the reservation is guaranteed.
  static const inProgress = 3; // The reservation is currently underway, and the guest is staying in the room.
  static const cancelled = 4; // The reservation has been canceled before its start date.
  static const noShow = 5; //The guest did not show up, and the reservation is considered a "no show."
  static const issue = 6; // There may be a problem with the reservation that requires special attention or resolution.
  static const all = 1000;
  //Gets
  String? getNumberOfPerson(){
    return numberOfPerson;
  }
  String? getInitialDate(){
    return initialDate;
  }

  String? getFinalDate(){
    return finalDate;
  }

  int? getRoomId(){
    return roomId;
  }
  String? getRoomName(){
    return roomName;
  }
  String? getPrice(){
    return price;
  }
  

  String? getStatusPayment(){
    return statusPayment;
  }
 
  List? getFullNameOfPerson(){
    return fullNameOfPerson != null ? json.decode(fullNameOfPerson!) : [];
  }

  String? getStatus(){
    return status;
  }
  bool? getTypePayment(){
    return typePayment;
  }

  //SETs
  void setTypePayment(bool? typePayment){
    this.typePayment = typePayment;
  }

   void setNumberOfPerson(int? numberOfPerson){
    this.numberOfPerson = numberOfPerson.toString();
  }

  void setfinalDate(String? finalDate){
    this.finalDate = finalDate;
  }

  void setInitialDate(String? initialDate){
    this.initialDate = initialDate;
  }

  void setRoomId(int? roomId){
    this.roomId = roomId!;
  }

  void setRoomName(String? roomName){
    this.roomName = roomName;
  } 
    void setPrice(String? price){
    this.price = price;
  }
  void setStatusPayment(String? statusPayment){
    this.statusPayment = statusPayment;
  }

  

  void setFullNameOfPerson(List? fullNameOfPerson){
     this.fullNameOfPerson = fullNameOfPerson != null ? jsonEncode(fullNameOfPerson) : '';
  }
  void setStatus(String? status){
    this.status = status;
  }

  // OTHER METHODS
  Map<String, dynamic> toMap() {
    return {
      'serverId': serverId,
      'initialDate': initialDate,
      'finalDate': finalDate,
      'roomId': roomId,
      'roomName':roomName,
      'price':price,
      'statusPayment':statusPayment, 
      'fullNameOfPerson':fullNameOfPerson,
      'status':status
    };
  }


  documentSuported(){
    return [
      'DNI',
      'NIE',
      'Pasaporte'
    ];
  }


  static allStatus(){
    return [
      Booking.all, Booking.completed, Booking.pending, Booking.confirmed, Booking.inProgress, Booking.cancelled,
    ];
  }

  static allNameStatus(int status){
    switch(status){
      case Booking.all:
        return 'Todos';
      case  Booking.completed:
        return 'Terminadas';
      case  Booking.pending:
        return 'Pendiente por confirmación';
      case  Booking.confirmed:
        return 'La reservas está garantizadas';
      case  Booking.inProgress:
        return 'En proceso';
      case  Booking.cancelled:
        return 'Canceladas';

    }
  }
}
