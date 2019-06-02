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

class QuoteCategory{
  static final String random = "random";
  static final String inspirational = "inspirational";
  static final String motivational = "motivational";
  static final String happiness = "happiness";
  static final String frienship = "frienship";
  static final String family = "family";
  static final String funny = "funny";
  static final String spiritual = "spiritual";
  static final String nature = "nature";
  static final String love = "love";
  static final String work = "work";
  static final String attitude = "attitude";

  static final List<String> categories = [random,
  inspirational,
  motivational,
  happiness,
  frienship,
  family,
  funny,
  spiritual,
  nature,
  love,
  work,
  attitude,];
}

class Settings{
  String refreshPeriod;
  int refreshPeriodValue;
  String quoteLength;
  String category;

  Settings({this.refreshPeriod, this.refreshPeriodValue, this.quoteLength, this.category});

  Settings.fromMap(Map<String, dynamic> map){
    refreshPeriod = map["refreshPeriod"];
    refreshPeriodValue = map["refreshPeriodValue"];
    quoteLength = map["quoteLength"];
    category = map["category"];
  }

  Map<String, dynamic> toMap(){
    return {
      "refreshPeriod": refreshPeriod,
      "refreshPeriodValue": refreshPeriodValue,
      "quoteLength": quoteLength,
      "category": category
    };
  }
}