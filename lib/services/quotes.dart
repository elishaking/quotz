import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quotz/models/settings.dart';


class QuotesService{
  String _url = "https://quotz.skyblazar.com/api/quote";
  // String _url = "http://192.168.43.130:8000/api/quote";
  String _accessKey = "dU7n@#s3ls/'sj8ksjdmV%42wx'ldjvs&8*AjskU";
  
  Future<String> getQuote(Settings settings) async{
    http.Response response = await http.get("$_url/${settings.category}/${settings.quoteLength}",
    headers: {
      "Authorization": "Bearer: $_accessKey"
    });
    print(response.body);

    return jsonDecode(response.body)["data"]["quote"];
  }
}