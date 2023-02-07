class CityModel {
  late int CityID1;
  late String CityName1;
  late int StateID1;

  CityModel({required this.CityID1,required this.CityName1,required this.StateID1});
  int get CityID => CityID1;

  set CityID(int value) {
    CityID1 = value;
  }

  String get CityName => CityName1;

  set CityName(String value) {
    CityName1 = value;
  }

  int get StateID => StateID1;

  set StateID(int value) {
    StateID1 = value;
  }
}
