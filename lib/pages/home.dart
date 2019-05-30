import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quotz/services/quotes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  String _quote;
  QuotesService _quotesService;

  TimeOfDay _timeOfDay;
  Timer _timer;

  @override
  void initState() {
    _quotesService = QuotesService();
    _loading = true;
    _quotesService.getQuote().then((String quote){
      setState(() {
        _quote = quote;
        _loading = false;  
      });
    });

    _timer = Timer.periodic(Duration(milliseconds: 500), (Timer t){
      setState(() {
       _timeOfDay = TimeOfDay.now(); 
      });
    });

    super.initState();
  }

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
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: _buildTime(),
              ),
            ),
            _loading ? Center(
              child: CircularProgressIndicator(),
            ) : RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                // TextSpan(text: "\" ",
                // style: TextStyle(color: Colors.white)),
                TextSpan(text: _quote),
                // TextSpan(text: " \"", 
                // style: TextStyle(color: Colors.white)),
              ], style: TextStyle(
                fontSize: 20,
                color: Colors.white54,
              )),
            )
          ],
        ),
      ),
    );
  }

  Row _buildTime() {
    double space = 5;
    double textSize = 120;
    String t = _timeOfDay.format(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${t.split(":")[0]}", style: TextStyle(
          fontSize: textSize
        )),
        SizedBox(width: space,),
        Text(":", style: TextStyle(
          fontSize: textSize
        )),
        SizedBox(width: space,),
        Text("${t.split(":")[1].split(" ")[0]}", style: TextStyle(
          fontSize: textSize
        )),
        SizedBox(width: space * 2,),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Text("${t.split(":")[1].split(" ")[1]}", style: TextStyle(
            fontSize: 20
          )),
        )
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}