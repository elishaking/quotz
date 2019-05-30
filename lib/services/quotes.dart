import 'dart:convert';
import 'package:http/http.dart' as http;


class QuotesService{
  String _url = "http://192.168.43.130:8000/api/quote";

  Future<String> getQuote() async{
    http.Response response = await http.get(_url,
    headers: {});

    return jsonDecode(response.body)["data"]["quote"];
  }
}