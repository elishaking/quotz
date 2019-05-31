class RefreshPeriod{
  static final String minutes = "minutes";
  static final String seconds = "seconds";
  static final String hours = "hours";
}

class QuoteLength{
  static final String short = "short";
  static final String medium = "medium";
  static final String long = "long";
  static final String random = "random";
}

class Settings{
  String refreshPeriod;
  int refreshPeriodValue;
  String quoteLength;

  Settings({this.refreshPeriod, this.refreshPeriodValue, this.quoteLength});

  Settings.fromMap(Map<String, dynamic> map){
    refreshPeriod = map["refreshPeriod"];
    refreshPeriodValue = map["refreshPeriodValue"];
    quoteLength = map["quoteLength"];
  }

  Map<String, dynamic> toMap(){
    return {
      "refreshPeriod": refreshPeriod,
      "refreshPeriodValue": refreshPeriodValue,
      "quoteLength": quoteLength
    };
  }
}