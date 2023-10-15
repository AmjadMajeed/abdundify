import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IntroTwo.dart';

class IntroOne extends StatefulWidget {
  const IntroOne({Key? key}) : super(key: key);

  @override
  State<IntroOne> createState() => _IntroOneState();
}


class _IntroOneState extends State<IntroOne> {


  @override
  void initState() {

    responceGet();
    super.initState();
  }


  responceGet() {

    Timer(Duration(seconds: 4), () async {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            IntroTwo()), (Route<dynamic> route) => false);

    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,

      child: Image.asset('assets/icons/introOne.png',fit: BoxFit.fill,),
    );
  }
}
