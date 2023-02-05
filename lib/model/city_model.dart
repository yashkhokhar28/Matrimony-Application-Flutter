class CityModel {
  late int _CityID;
  late String _CityName;
  late int _StateID;

  int get CityID => _CityID;

  set CityID(int value) {
    _CityID = value;
  }

  String get CityName => _CityName;

  set CityName(String value) {
    _CityName = value;
  }

  int get StateID => _StateID;

  set StateID(int value) {
    _StateID = value;
  }
}
