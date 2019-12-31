

class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList ) {
    if ( jsonList == null ) return;

    for ( var item in jsonList) {
       final pelicula = new Pelicula.fromJsonMap(item);
        items.add( pelicula );
    }
  }
}



class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap( Map<String,dynamic> json ) {
    popularity       = json['popularity'] / 1;
    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];
  }

  getPosterImg() {

    if ( posterPath == null)  {
      return 'http://www.clker.com/cliparts/q/L/P/Y/t/6/no-image-available-hi.png';
    } else {
        return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

    getBackgroundImg() {

    if ( backdropPath == null)  {
      return 'http://www.clker.com/cliparts/q/L/P/Y/t/6/no-image-available-hi.png';
    } else {
        return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }


}


