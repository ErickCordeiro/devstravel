import 'package:flutter/material.dart';

class CompanyBox extends StatelessWidget{
  CompanyBox({ @required this.data, this.onTap });

  final data;
  final Function onTap;

  @override 
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: (){
          onTap(data);
        },
        child: Stack(
          children: <Widget>[
            
            AspectRatio(
              aspectRatio: 1/1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20)
                )
              )
            ),

            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  data['places'][0]['img'],
                  fit: BoxFit.cover
                )
              )
            )

          ],
        ),
      )
    );
  }
}