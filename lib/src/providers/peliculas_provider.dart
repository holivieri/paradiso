
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paradiso/src/models/actores_model.dart';
import 'package:paradiso/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey = '177eb9c94cb787a708460366e8f7e858';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;




  void disposeStreams() {
    _popularesStreamController?.close();
  }


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    // print(decodedData['results']);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
    
  }


  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language
    });
    return _procesarRespuesta(url);
    
  }





    Future<List<Pelicula>> getPopulares() async {
    
    if ( _cargando) return [];

    _cargando = true;
    
    _popularesPage++;


    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);  //Stream par agregar info y notificar al widget
    
    _cargando = false;

    return resp;
  }

    Future<List<Actor>> getCast( int peliId) async {
      final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'  : _apiKey,
      'language' : _language
    });
      
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);

      final cast = new Cast.fromJsonList(decodedData['cast']);
      print ( cast.actores);
      return cast.actores;

    }
}