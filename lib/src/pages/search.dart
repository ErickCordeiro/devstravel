import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/companybox.dart';

class SearchPage extends StatefulWidget{
  @override 
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage>{

  var list = [];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void  doSearch(pageContext, text) async{
    var newList = await Provider.of<AppData>(pageContext).searchCompany(text);

    setState(() {
      list = newList;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          pageContext: context,
          title: 'Busque uma Empresa',
          hideSearch: true
        ),
        drawer: CustomDrawer(pageContext: context),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Digite o nome da Empresa',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search, size: 32)
                ),
                onChanged: (text){
                  doSearch(context, text);
                },
              )
            ),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(list.length, (index){
                  return CompanyBox(
                    data: list[index], 
                    onTap: (companyData){
                      Navigator.pushNamed(context, '/company', arguments: companyData);
                    });
                }),
              )
            )

          ],
        )
      ),
    );
  }
}