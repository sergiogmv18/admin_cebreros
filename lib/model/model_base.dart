
class ModelBase{
  int ?serverId;
  ModelBase({this.serverId});

  // GETs
  int? getServerId(){
    return serverId;
  }
  // SETs
  void setServerId(int? serverId){
    this.serverId = serverId;
  }
}