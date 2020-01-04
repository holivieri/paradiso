import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando el usuario escribe
    return Container();
  }




}