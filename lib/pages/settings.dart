import 'package:flutter/material.dart';

import '../models/settings.dart';

class SettingsPage extends StatefulWidget {
  final Settings settings;

  SettingsPage(this.settings);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // String _refreshPeriod = RefreshPeriod.hours;
  // int _refreshPeriodValue = 2;

  // String _quoteLength = QuoteLength.random;

  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    _editingController.text = widget.settings.refreshPeriodValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white54),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            int r = int.tryParse(_editingController.text);
            if(r != null)
              widget.settings.refreshPeriodValue = r;

            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text("Quotes", style: Theme.of(context).textTheme.title.merge(TextStyle(
              color: Colors.white54
            )),),
          ),
          Card(
            color: Colors.white12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Refresh Every"),
                  Container(
                    width: 170,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            controller: _editingController,
                            // initialValue: widget.settings.refreshPeriodValue.toString(),
                            cursorColor: Colors.white54,
                            style: new TextStyle(
                              color: Colors.white,
                              
                            ),
                            keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(0),
                                )
                              )
                            ),
                            
                          ),
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(30),
                            )
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(widget.settings.refreshPeriod),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return _buildAlertDialog(context);
                              }
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Quote Length"),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(widget.settings.quoteLength),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return _buildQuoteLengthAlertDialog(context);
                        }
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }

  AlertDialog _buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Duration"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text("seconds"),
            trailing: Icon(Icons.arrow_forward_ios,
            size: 20,),
            contentPadding: EdgeInsets.only(left: 5),
            onTap: (){
              setState(() {
                widget.settings.refreshPeriod = RefreshPeriod.seconds; 
              });
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text("minutes"),
            trailing: Icon(Icons.arrow_forward_ios,
            size: 20,),
            contentPadding: EdgeInsets.only(left: 5),
            onTap: (){
              setState(() {
                widget.settings.refreshPeriod = RefreshPeriod.minutes; 
              });
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text("hours"),
            trailing: Icon(Icons.arrow_forward_ios,
            size: 20,),
            contentPadding: EdgeInsets.only(left: 5),
            onTap: (){
              setState(() {
                widget.settings.refreshPeriod = RefreshPeriod.hours; 
              });
              Navigator.of(context).pop();
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  AlertDialog _buildQuoteLengthAlertDialog(BuildContext context){
    return AlertDialog(
      title: Text("Quote Length"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(QuoteLength.random),
            trailing: Icon(Icons.arrow_forward_ios,
            size: 20,),
            contentPadding: EdgeInsets.only(left: 5),
            onTap: (){
              setState(() {
                widget.settings.quoteLength = QuoteLength.random; 
              });
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text(QuoteLength.short),
            trailing: Icon(Icons.arrow_forward_ios,
            size: 20,),
            contentPadding: EdgeInsets.only(left: 5),
            onTap: (){
              setState(() {
                widget.settings.quoteLength = QuoteLength.short; 
              });
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text(QuoteLength.medium),
            trailing: Icon(Icons.arrow_forward_ios,
            size: 20,),
            contentPadding: EdgeInsets.only(left: 5),
            onTap: (){
              setState(() {
                widget.settings.quoteLength = QuoteLength.medium; 
              });
              Navigator.of(context).pop();
            },
          ),
          Divider(),
          ListTile(
            title: Text(QuoteLength.long),
            trailing: Icon(Icons.arrow_forward_ios,
            size: 20,),
            contentPadding: EdgeInsets.only(left: 5),
            onTap: (){
              setState(() {
                widget.settings.quoteLength = QuoteLength.long; 
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}