import 'dart:convert';

import 'package:demo_app/model.dart';
import 'package:http/http.dart' as http;

class Api {

  static Future<PokemonStats> getStats(String pokemon) async {
    try {
      final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$pokemon"));
    if (response.statusCode == 200) {
      return PokemonStats.fromJson(Map.from(jsonDecode(response.body)));
    } else {
      throw response.body;
    }
    } catch (e, stk) {
      print(e);
      print(stk);
      rethrow;
    }
  }
}