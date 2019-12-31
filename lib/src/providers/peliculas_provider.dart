
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paradiso/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey = '177eb9c94cb787a708460366e8f7e858';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language
    });

    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    print(decodedData['results']);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

    Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : _apiKey,
      'language' : _language
    });

    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    print(decodedData['results']);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }


}