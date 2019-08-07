import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotz/models/quote.dart';
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
  Quote _quote = Quote(quote: "", author: "");
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
    _quotesService.getQuote(_settings).then((Quote quote){
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
        padding: EdgeInsets.only(
          left: responsive(context, 20), right: responsive(context, 20), top: responsive(context, 70), bottom: 10
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: _buildTime(),
              ),
            ),
            if(_loading) ...[
              Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),),
              ),
              SizedBox(height: 20,)
            ],
            // RichText(
            //   textAlign: TextAlign.center,
            //   text: TextSpan(children: [
            //     // TextSpan(text: "\" ",
            //     // style: TextStyle(color: Colors.white)),
            //     TextSpan(text: _quote.quote),
            //     // TextSpan(text: " \"", 
            //     // style: TextStyle(color: Colors.white)),
            //   ], style: TextStyle(
            //     fontSize: responsive(context, 20),
            //     color: Colors.white54,
            //   )),
            // ),
            // RichText(
            //   textAlign: TextAlign.center,
            //   text: TextSpan(
            //     style: TextStyle(fontFamily: 'Poppins',),
            //     children: [
            //       TextSpan(text: "[ "),
            //       TextSpan(text: _quote.category, style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white70,
            //         letterSpacing: 0.7
            //       )),
            //       TextSpan(text: " ]")
            //     ]
            //   ),
            // ),
            SizedBox(height: 20,),
            Text(_quote.quote, style: TextStyle(
              fontSize: responsive(context, 20),
              color: Colors.white54,
            ),
            textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Text(_quote.author, style: TextStyle(
              fontSize: responsive(context, 17),
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 0.7
            ))
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
          height: 0,
          fontSize: textSize,
        )),
        SizedBox(width: space,),
        Text(":", style: TextStyle(
          height: 0,
          fontSize: textSize,
        )),
        SizedBox(width: space,),
        Text("${t.split(":")[1].split(" ")[0]}", style: TextStyle(
          height: 0,
          fontSize: textSize
        )),
        SizedBox(width: space * 2,),
        Text("${t.split(":")[1].split(" ")[1]}", style: TextStyle(
          height: 0,
          fontSize: responsive(context, 30)
        )),
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