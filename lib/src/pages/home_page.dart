//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradiso/src/providers/peliculas_provider.dart';
import 'package:paradiso/src/search/search_delegate.dart';
import 'package:paradiso/src/widgets/card_swiper_widget.dart';
import 'package:paradiso/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {
  
   final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares(); //cargo las peliculas iniciales

    return Scaffold(
        appBar: AppBar(
          title: Text('Buscar...'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: DataSearch()
               ); 
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,  
            children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],)
        )
      );
  }

  Widget _swiperTarjetas() {
   
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if (snapshot.hasData) {
          return CardSwiper( peliculas: snapshot.data);
        } else {
          return Container(
                        height: 400.0,
                        child: Center(
                                  child: CircularProgressIndicator()
                                  )
                          );
        }
        
      }
      );
  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
            children: <Widget>[
              Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text('Populares', style: Theme.of(context).textTheme.subhead)
                    ),
              SizedBox(height: 5.0),
              StreamBuilder(
                stream: peliculasProvider.popularesStream,

                builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return MovieHorizontal(
                                     peliculas: snapshot.data,
                                     siguientePagina: peliculasProvider.getPopulares,
                                  );
                      } else {
                        return Container(
                                      height: 100.0,
                                      child: Center(
                                                child: CircularProgressIndicator()
                                                )
                                        );
                      }
                },

              )

            ],)
      ,
    );


  }

}