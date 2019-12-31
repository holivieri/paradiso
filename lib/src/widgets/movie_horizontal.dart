import 'dart:js';

import 'package:flutter/material.dart';
import 'package:paradiso/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina });
    final Function siguientePagina;

    final _pageController = new PageController(
        initialPage: 1,
        viewportFraction: 0.3 //30% para que entren un poco mas de 3 por pagina
    );


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      //verifico si esto cerca del final del scroll horizontal
        if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
           print('cargar siguientes peliculas');
          siguientePagina();
        }
    });


    return Container(
        height: _screenSize.height * 0.2,
        child: PageView.builder(
          pageSnapping: false,
          controller:_pageController,
          //children: _tarjetas(context),
          itemCount: peliculas.length,
          itemBuilder: (context, i) =>  _tarjeta(context, peliculas[i]),
        ),

    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map( (pelicula) {
        return Container(
            margin:  EdgeInsets.only(right: 15.0),
            child: Column(  
              children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                        image: NetworkImage( pelicula.getPosterImg()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                        height: 120.0,
                    ),
                  ),
                  //SizedBox(height: 5.0),
                  Text(
                    pelicula.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  )
                  ],
            ),
        );
    } ).toList();
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {

     return Container(
            margin:  EdgeInsets.only(right: 15.0),
            child: Column(  
              children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                        image: NetworkImage( pelicula.getPosterImg()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                        height: 120.0,
                    ),
                  ),
                  //SizedBox(height: 5.0),
                  Text(
                    pelicula.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  )
                  ],
            ),
        )


  }


}