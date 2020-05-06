import 'package:flutter/material.dart';

Widget CustomDrawer({
  BuildContext pageContext
}){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[

        DrawerHeader(
          child: Center(
            child: Image.asset('lib/assets/logo.png', width: 200)
          ),
          decoration: BoxDecoration(
            color: Color(0xFFFE6601),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(45))
          ),
        ),

        ListTile(
          leading: Icon(Icons.list, color: Color(0xFF09003B)),
          title: Text("Lista de Empresas"),
          onTap: (){
            Navigator.pushReplacementNamed(pageContext, '/home');
          },
        ),

        ListTile(
          leading: Icon(Icons.search, color: Color(0xFF09003B)),
          title: Text("Buscar Empresas"),
          onTap: (){
            Navigator.pushReplacementNamed(pageContext, '/search');
          },
        ),

        ListTile(
          leading: Icon(Icons.favorite, color: Color(0xFF09003B)),
          title: Text("Favoritos"),
          onTap: (){
            Navigator.pushReplacementNamed(pageContext, '/favorites');
          },
        ),

        // ListTile(
        //   leading: Icon(Icons.chat, color: Color(0xFF09003B)),
        //   title: Text("Chat"),
        //   onTap: (){
        //     Navigator.pushReplacementNamed(pageContext, '/chat');
        //   },
        // ),

      ],
    )
  );
}