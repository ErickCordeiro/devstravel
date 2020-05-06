import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/companybox.dart';

class HomePage extends StatelessWidget{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void seeCompanyAction( context, companyIndex ){
    Navigator.pushNamed( context, '/listcompany', arguments: companyIndex);
  }

  void companyBoxAction(pageContext, companyData ) {
    Navigator.pushNamed( pageContext, '/company', arguments: companyData);
  }

  @override 
  Widget build(BuildContext context){
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          scaffoldKey: _scaffoldKey,
          pageContext: context,
          title: 'Empresas'
        ),
        drawer: CustomDrawer(pageContext: context),
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: appdata.data.length,
            itemBuilder: (context, index){
          
            var companies = [];

            for(var company in appdata.data[index]['countries']){
              companies.addAll( company['cities'] );
            }
            
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   Container(
                     margin: EdgeInsets.only(left: 15),
                     child: Text(
                      '${appdata.data[index]['name']} (${companies.length})',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                        )
                      )
                   ),

                    FlatButton( 
                      child: Text(
                        'Ver todos',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: (){
                        seeCompanyAction( context, index );
                      },
                    )
                ],),

                Container(
                  height: 125,
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: companies.length,
                    itemBuilder: (companyContext, companyIndex){
                      return CompanyBox(
                        data: companies[companyIndex],
                        onTap: (companyData){
                          companyBoxAction(context, companyData);
                        }
                      );
                    },
                  ),
                )
              ],
            );
          },
        )
      ),
    );
  }
}