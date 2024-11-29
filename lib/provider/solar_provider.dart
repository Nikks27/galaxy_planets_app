import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/solar_modal.dart';

class SolarProvider extends ChangeNotifier {
  List<SolarModal> solarList = [];
  int selectindex = 0;
  List<SolarModal> favoutiteList = [];

  Future<void> getData() async {
    String jsonData = await rootBundle.loadString('assets/plante.json');
    List json = jsonDecode(jsonData);
    solarList = json
        .map(
          (e) => SolarModal.fromJson(e),
        )
        .toList();
    notifyListeners();
  }

  void changePlanteIndex(int index) {
    selectindex = index;
    notifyListeners();
  }

  SolarProvider() {
    getData();
    getShareData();
  }

  void favouriteAdd() {
    solarList[selectindex].like = !solarList[selectindex].like;
    notifyListeners();
    if (solarList[selectindex].like) {
      favoutiteList.add(solarList[selectindex]);
      notifyListeners();
    } else {
      favoutiteList.remove(solarList[selectindex]);
      notifyListeners();
    }
    setShareData();
    notifyListeners();
  }

  void removeFavourite(int index) {
    var planetToRemove = favoutiteList[index];

    for (var planet in solarList) {
      if (planet.name == planetToRemove.name) {
        planet.like = false;
        break;
      }
    }
    favoutiteList.removeAt(index);

    setShareData();
    notifyListeners();
  }

  Future<void> setShareData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for (int i = 0; i < solarList.length; i++) {
     sharedPreferences.setBool("like$i", solarList[i].like);
    }
    notifyListeners();
  }

  Future<void> getShareData()
  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for (int i = 0; i < solarList.length; i++) {
      solarList[i].like = sharedPreferences.getBool('like$i') ?? false;
      notifyListeners();
      if(solarList[i].like)
        {
          favoutiteList.add(solarList[i]);
        }
    }
    setShareData();
    notifyListeners();
  }
}
