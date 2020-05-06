import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/companybox.dart';

class ListCompany extends StatelessWidget{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void companyBoxAction( pageContext, companyData ) {
    Navigator.pushNamed(pageContext, '/company', arguments: companyData);
  }

  @override 
  Widget build(BuildContext context){
    final companyIndex = ModalRoute.of(context).settings.arguments;
    return Consumer<AppData>(
      builder: (ctx, appdata, child) {
        var companies = [];
        for(var company in appdata.data[companyIndex]['countries']){
          companies.addAll( company['cities'] );
        }

        return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            scaffoldKey: _scaffoldKey,
            pageContext: context,
            title: "${appdata.data[companyIndex]['name']} (${companies.length} empresas)",
            showBack: true
          ),
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Colors.white,
          body: GridView.count(
            crossAxisCount: 3,
            children:
              List.generate(
                companies.length, ( index ) {
                  return CompanyBox(
                    data: companies[index],
                    onTap: (companyData){
                      companyBoxAction(context, companyData);
                    }
                  );
                }
              )
          )
        );
      }
    );
  }
}