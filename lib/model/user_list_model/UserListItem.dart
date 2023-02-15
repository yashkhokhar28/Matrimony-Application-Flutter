import 'dart:convert';
/// name : "Monica Daugherty"
/// Dob : "1997-07-26T09:50:48.656Z"
/// City : "Cranston"
/// id : "1"
//
// UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));
// String userListModelToJson(UserListModel data) => json.encode(data.toJson());
class UserListItem {
  UserListItem({
      String? name, 
      String? dob, 
      String? city, 
      String? id,}){
    _name = name;
    _dob = dob;
    _city = city;
    _id = id;
}

  UserListItem.fromJson(dynamic json) {
    _name = json['name'];
    _dob = json['Dob'];
    _city = json['City'];
    _id = json['id'];
  }
  String? _name;
  String? _dob;
  String? _city;
  String? _id;
UserListItem copyWith({  String? name,
  String? dob,
  String? city,
  String? id,
}) => UserListItem(  name: name ?? _name,
  dob: dob ?? _dob,
  city: city ?? _city,
  id: id ?? _id,
);
  String? get name => _name;
  String? get dob => _dob;
  String? get city => _city;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['Dob'] = _dob;
    map['City'] = _city;
    map['id'] = _id;
    return map;
  }

}