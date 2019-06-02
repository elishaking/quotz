import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotz/models/settings.dart';
import 'package:quotz/pages/settings.dart';
import 'package:quotz/services/quotes.dart';
import 'package:quotz/services/settings.dart';
import 'package:quotz/utils/responsive.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SettingsService _settingsService;
  Settings _settings;

  bool _loading = false;
  String _quote;
  QuotesService _quotesService;

  TimeOfDay _timeOfDay;
  Timer _timer, _quoteTimer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    _settingsService = SettingsService();
    _settingsService.getSettings().then((Settings settings){
      _settings = settings;

      _quotesService = QuotesService();
      _getQuote();
      _quoteTimer = Timer.periodic(_getDuration(), (Timer t){
        _getQuote();
      });
    });


    _timeOfDay = TimeOfDay.now(); 
    _timer = Timer.periodic(Duration(milliseconds: 500), (Timer t){
      setState(() {
       _timeOfDay = TimeOfDay.now(); 
      });
    });

    super.initState();
  }

  Duration _getDuration() {
    if(_settings.refreshPeriod == RefreshPeriod.seconds){
      return Duration(seconds: _settings.refreshPeriodValue);
    } else if(_settings.refreshPeriod == RefreshPeriod.seconds){
      return Duration(minutes: _settings.refreshPeriodValue);
    } else {
      return Duration(hours: _settings.refreshPeriodValue);
    }
  }

  void _getQuote() {
    _loading = true;
    _quotesService.getQuote(_settings).then((String quote){
      setState(() {
        _quote = quote;
        _loading = false;  
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white54,),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SettingsPage(_settings)
              )).then((_){
                _settingsService.storeSettings(_settings);
                _quoteTimer.cancel();
                _quoteTimer = Timer.periodic(_getDuration(), (Timer t){
                  _getQuote();
                });
              });
            },
          )
        ],
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
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),),
            ) : RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                // TextSpan(text: "\" ",
                // style: TextStyle(color: Colors.white)),
                TextSpan(text: _quote),
                // TextSpan(text: " \"", 
                // style: TextStyle(color: Colors.white)),
              ], style: TextStyle(
                fontSize: responsive(context, 20),
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
    double textSize = responsive(context, 120);
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
          padding: EdgeInsets.only(top: responsive(context, 80)),
          child: Text("${t.split(":")[1].split(" ")[1]}", style: TextStyle(
            fontSize: responsive(context, 30)
          )),
        )
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _quoteTimer.cancel();
    super.dispose();
  }
}