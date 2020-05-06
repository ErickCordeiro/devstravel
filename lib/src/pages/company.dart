import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customdrawer.dart';

class CompanyPage extends StatefulWidget{
  @override 
  _CompanyPage createState() => _CompanyPage();
}

class _CompanyPage extends State<CompanyPage>{
  bool heart = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void backButtonAction(pageContext){
    Navigator.pop(pageContext);
  }

  @override 
  Widget build(BuildContext context){

    Map<String, dynamic> companyData = ModalRoute.of(context).settings.arguments;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double footerHeight = MediaQuery.of(context).padding.bottom;

    return Consumer<AppData>(
      builder: (ctx, appdata, child){

        heart = appdata.hasFavorite(companyData['name']);

        return Scaffold(
          key: _scaffoldKey,
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[

              //Imagem
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                height: 270,
                child: Image.network(
                  companyData['places'][0]['img'],
                  fit: BoxFit.cover
                )
              ),

              //Conteúdo
              ListView(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: <Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
                              width: 240,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      companyData['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ),
      
                                  //Colocar o Endereço da Empresa
                                  Text(
                                    "Av. Hagemo Matsuzawa, 741 loja 1, Vila Ribeiropolis - Registro - SP",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                    )
                                  ),

                                ],
                              ),
                            ),

                          //Botão de Favorito
                          Container(
                            width: 75,
                            child: FlatButton(
                              child: Icon(heart ? Icons.favorite : Icons.favorite_border , color: Colors.red, size: 30),
                              onPressed: (){
                                setState((){
                                  heart = appdata.favorite(companyData['name']);
                                });
                              }
                            )
                          )

                          ],
                        ),

                        //Detalhes da Empresa
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                              child: FlatButton(
                                  onPressed: (){},
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.phone_in_talk, color: Color(0xFF09003B)),
                                      Text("Telefone", style: TextStyle(fontSize: 14),)
                                    ],
                                  )
                                )
                              ),

                              Expanded(
                                child: FlatButton(
                                  onPressed: (){},
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.map, color: Color(0xFF09003B)),
                                      Text("Endereço", style: TextStyle(fontSize: 14),)
                                    ],
                                  )
                                )
                              ),

                              Expanded(
                                child: FlatButton(
                                  onPressed: (){},
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.tag_faces, color: Color(0xFF09003B)),
                                      Text("Facebook", style: TextStyle(fontSize: 14),)
                                    ],
                                  )
                                )
                              ),

                              Expanded(
                                child: FlatButton(
                                  onPressed: (){},
                                  child: Column(
                                    children: <Widget>[
                                      Icon(Icons.perm_identity, color: Color(0xFF09003B)),
                                      Text("Instagram", style: TextStyle(fontSize: 14),)
                                    ],
                                  )
                                )
                              )
                            ],
                          )
                        ),

                        Container(
                          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child:  Divider(
                            thickness: 1,
                          )
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: Text(
                              companyData['description'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                              ),
                            )
                        ),

                        Container(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            "Nossos Produtos",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                        ),

                        GridView.count(
                          padding: EdgeInsets.only(bottom: footerHeight),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 10 / 11,
                          children:
                            List.generate(
                              companyData['places'].length,
                              (index){
                                
                                return Container(
                                  child: Column(
                                    children: <Widget>[

                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              companyData['places'][index]['img'],
                                              fit: BoxFit.cover
                                            ),
                                          )
                                        )
                                      ),

                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          companyData['places'][index]['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                );

                              }
                            ),
                        )

                      ],
                    )
                  )
                ],
              ),

              //Botão Boltar
              Container(
                margin: EdgeInsets.only(top: statusBarHeight),
                height: 50,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: (){
                    backButtonAction(context);
                  },
                )
              ),

            ],
          )
        );
      }
    );
  }
}