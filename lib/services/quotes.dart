import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotz/models/settings.dart';


class QuotesService{
  String _url = "https://quotz.skyblazar.com/api/quote";

  Future<String> getQuote(Settings settings) async{
    http.Response response = await http.get("$_url?c=${settings.refreshPeriod}&length=${settings.quoteLength}",
    headers: {});

    return jsonDecode(response.body)["data"]["quote"];
  }
}