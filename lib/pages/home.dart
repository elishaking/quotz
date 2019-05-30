import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: _buildTime(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text("\"lodxjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj\"", style: TextStyle(
                fontSize: 40
              ),),
            )
          ],
        ),
      ),
    );
  }

  Row _buildTime() {
    double space = 5;
    double textSize = 130;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("9", style: TextStyle(
          fontSize: textSize
        )),
        SizedBox(width: space,),
        Text(":", style: TextStyle(
          fontSize: textSize
        )),
        SizedBox(width: space,),
        Text("30", style: TextStyle(
          fontSize: textSize
        )),
        SizedBox(width: space,),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Text("PM", style: TextStyle(
            fontSize: 30
          )),
        )
      ],
    );
  }
}