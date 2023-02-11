class UserModel{
  late int _UserID;
  late String _Name;
  late String _DOB;
  late int _CityID;
  late bool _isFavouriteUser;

  bool get isFavouriteUser => _isFavouriteUser;

  set isFavouriteUser(bool isFavouriteUser) {
    _isFavouriteUser = isFavouriteUser;
  }

  int get UserID => _UserID;

  set UserID(int value) {
    _UserID = value;
  }


  String get Name => _Name;

  set Name(String value) {
    _Name = value;
  }

  String get DOB => _DOB;

  set DOB(String value) {
    _DOB = value;
  }


  int get CityID => _CityID;

  set CityID(int value) {
    _CityID = value;
  }
}