import 'package:flutter/material.dart';
import 'package:paradiso/src/models/pelicula_model.dart';
import 'package:paradiso/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion = '';
  final peliculasProvicer = new PeliculasProvider();


  final peliculas = [
    'Volver al futuro',
    'Volver al futuro 2',
    'Volver al futuro 3',
    'Superman',
    'Batman',
    'IT',
    'Batman 2',
    'Batman 3',
    'Aquaman'
  ];

  final peliculasRecientes = [
    'Ironman',
    'Capitan America',

  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones del appBar, ej cancelar o limpiar
    return [
      IconButton(
              icon: Icon(Icons.clear) ,
              onPressed: () {
                query = '';
              },
              
              )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda
    return IconButton(
                      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,),
                      onPressed: () {
                      close(context, null);
                    },

              
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados de la busqueda
    return Center(
                  child: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.blueAccent,
                      child: Text(seleccion)
                  )
                );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando el usuario escribe
    if ( query.isEmpty ) return Container();

    return FutureBuilder(
      future: peliculasProvicer.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if ( snapshot.hasData) {
                final peliculas = snapshot.data;
                return  ListView(
                        children: peliculas.map( (pelicula){
                                    return ListTile(
                                      leading: FadeInImage(
                                            image: NetworkImage( pelicula.getPosterImg()),
                                            placeholder: AssetImage('assets/img/no-image.jpg'),
                                            width: 50.0,
                                            fit: BoxFit.contain,
                                            ),
                                            title: Text( pelicula.title ),
                                            subtitle: Text( pelicula.originalTitle ),
                                            onTap: () {
                                              close(context, null);
                                              pelicula.uniqueId = '';
                                              Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                                            },
                                    );
                                  }).toList(),
                );


              } else {
                return Center(child: CircularProgressIndicator());
              }
      },
    );

  }



  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando el usuario escribe

  //   final listaSugerida = ( query.isEmpty) ? peliculasRecientes 
  //                                          : peliculas
  //                                           .where((p) => p.toLowerCase().startsWith(query.toLowerCase())
  //                                           ).toList();


  //   return ListView.builder(
  //                   itemCount: listaSugerida.length,
  //                   itemBuilder: (context, i) {
  //                       return ListTile(
  //                         leading: Icon(Icons.movie),
  //                         title: Text( listaSugerida[i]),
  //                         onTap: () {
  //                             seleccion = listaSugerida[i];
  //                             showResults(context);
  //                         },
  //                       );
  //                   },
  //   );
  // }



}