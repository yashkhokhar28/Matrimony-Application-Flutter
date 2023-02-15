
import 'package:matrimony/model/user_list_model/UserListItem.dart';

class UserListModel{
  List<UserListItem>? _resultList;
  LaptopModel({
    List<UserListItem>? resultList,
  }){
    _resultList=resultList;
  }


  List<UserListItem>? get resultList =>_resultList;
  UserListModel.fromJson(var json){
    if(json!=null){
      _resultList=[];
      json.toList().forEach((v){
        _resultList?.add(UserListItem.fromJson(v));
      });
    }
  }
}