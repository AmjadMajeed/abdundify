import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'introFive.dart';

class IntroFour extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroFive()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/icons/introFour.png',fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
