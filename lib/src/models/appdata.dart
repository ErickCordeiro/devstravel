import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppData with ChangeNotifier{

  var data = [];
  var favorites = [];

  List favoritesCompany(){
    List result = [];

    for(var favorite in favorites){
      List foundCompany = this.searchCompany(favorite);
      if(foundCompany.length > 0){
        result.add(foundCompany[0]);
      }
    }

    return result;
  }

  List searchCompany(text){
    List result = [];

    text = text.trim().toLowerCase();

    if(text == ''){
      return result;
    }

    //Alterar para o que for da empresa mais pra frente
    for(var continents in data ){
      for(var country in continents['countries']){
        for(var city in country['cities']){

          if(city['name'].toLowerCase().contains(text)){
            result.add(city);
          }

        }
      }
    }

    return result;
  }

  bool hasFavorite(companyName){
    return favorites.contains(companyName);
  }

  bool favorite(companyName){
    if(this.hasFavorite(companyName)){
      favorites.remove(companyName);
      return false;
    } else {
      favorites.add(companyName);
      return true;
    }
  }

  void setData(newData){
    data = newData;
    notifyListeners();
  }

  Future<bool> requestData() async{
    final res = await http.get('https://api.b7web.com.br/flutter1wb');

    if(res.statusCode == 200){

      setData(jsonDecode(res.body));
      return true;

    } else {
      return false;
    }
  }

}