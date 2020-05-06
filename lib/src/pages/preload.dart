import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';

class PreloadPage extends StatefulWidget{
  @override 
  _PreloadPage createState() => _PreloadPage();
}

class _PreloadPage extends State<PreloadPage>{
  bool loading = true;

  void requestInfo() async {

    await Future.delayed(Duration(seconds: 1));

    setState((){
      loading = true;
    });

    bool req = await Provider.of<AppData>(context).requestData();

    if(req){
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState((){
        loading = false;
      });
    }

  }

  void initState() {
    super.initState();
    requestInfo();
  }

  @override 
  Widget build(BuildContext context){

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      backgroundColor: Color(0xFFFE6601),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/logo.png',
                width: 200
              ),
              
              loading ? Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                    "Carregando informações...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    )
                  ),
               ) :Container(),

              loading ? CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )  : Container(),

              

              !loading ? Container(
                margin: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: (){},
                  child: Text("Tente novamente")
                  )
              ) : Container(),

            ] 
          )
        )
      )
    );
  }
}