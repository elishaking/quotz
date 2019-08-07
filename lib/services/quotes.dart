import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotz/models/quote.dart';
import 'package:quotz/models/settings.dart';


class QuotesService{
  String _url = "https://quotz.skyblazar.com/api/quote";
  // String _url = "http://192.168.43.130:8000/api/quote";
  String _accessKey = "dU7n@#s3ls/'sj8ksjdmV%42wx'ldjvs&8*AjskU";
  
  Future<Quote> getQuote(Settings settings) async{
    http.Response response = await http.get("$_url/${settings.category}/${settings.quoteLength}",
    headers: {
      "Authorization": "Bearer: $_accessKey"
    });
    // print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body)["data"];
    Quote quote = Quote(quote: data["quote"], author: data["author"], 
    category: data["category"]);

    return quote;
  }
}