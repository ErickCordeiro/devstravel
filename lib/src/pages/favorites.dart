import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/companybox.dart';

class FavoritesPage extends StatelessWidget{



  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override 
  Widget build(BuildContext context){
    return Consumer<AppData>(
      builder: (ctx, appdata, child){

        List favorites = appdata.favoritesCompany();
    
        return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            scaffoldKey: _scaffoldKey,
            pageContext: context,
            title: 'Meus Favoritos',
          ),
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Colors.white,
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(favorites.length, (index){
              return CompanyBox(
                data: favorites[index], 
                onTap: (companyData){
                  Navigator.pushNamed(context, '/company', arguments: companyData);
                });
            }),
          )
        );
      }
    );
  }
}