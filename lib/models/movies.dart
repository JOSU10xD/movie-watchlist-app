class Movie {
  final String imdbID;
  final String title;
  final String year;
  final String poster; // may be "N/A"

  Movie({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
  });

  /// Parse from OMDb Search array (`Search`)
  factory Movie.fromOmdbJson(Map<String, dynamic> json) {
    return Movie(
      imdbID: json['imdbID'] as String? ?? '',
      title:  json['Title']  as String? ?? 'Unknown',
      year:   json['Year']   as String? ?? 'Unknown',
      poster: json['Poster'] as String? ?? 'N/A',
    );
  }

  /// For persisting in watchlist
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbID: json['imdbID'] as String? ?? '',
      title:  json['title']  as String? ?? '',
      year:   json['year']   as String? ?? '',
      poster: json['poster'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'imdbID': imdbID,
        'title':  title,
        'year':   year,
        'poster': poster,
      };

  /// Safely get a poster URL or placeholder
  String get posterUrl {
    if (poster != 'N/A' && poster.startsWith('http')) {
      return poster;
    }
    return 'https://via.placeholder.com/50x75?text=No+Image';
  }
}

/// Detailed info for a single movie
class MovieDetail extends Movie {
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final List<Rating> ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String type;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;

  MovieDetail({
    required String imdbID,
    required String title,
    required String year,
    required String poster,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.type,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.website,
  }) : super(
          imdbID: imdbID,
          title: title,
          year: year,
          poster: poster,
        );

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      imdbID:   json['imdbID'] as String? ?? '',
      title:    json['Title']  as String? ?? 'Unknown',
      year:     json['Year']   as String? ?? 'Unknown',
      poster:   json['Poster'] as String? ?? 'N/A',
      rated:    json['Rated']  as String? ?? '',
      released: json['Released'] as String? ?? '',
      runtime:  json['Runtime']  as String? ?? '',
      genre:    json['Genre']    as String? ?? '',
      director: json['Director'] as String? ?? '',
      writer:   json['Writer']   as String? ?? '',
      actors:   json['Actors']   as String? ?? '',
      plot:     json['Plot']     as String? ?? '',
      language: json['Language'] as String? ?? '',
      country:  json['Country']  as String? ?? '',
      awards:   json['Awards']   as String? ?? '',
      ratings:  (json['Ratings'] as List<dynamic>? ?? [])
          .map((r) => Rating.fromJson(r as Map<String, dynamic>))
          .toList(),
      metascore:   json['Metascore']  as String? ?? '',
      imdbRating:  json['imdbRating'] as String? ?? '',
      imdbVotes:   json['imdbVotes']  as String? ?? '',
      type:        json['Type']       as String? ?? '',
      dvd:         json['DVD']        as String? ?? '',
      boxOffice:   json['BoxOffice']  as String? ?? '',
      production:  json['Production'] as String? ?? '',
      website:     json['Website']    as String? ?? '',
    );
  }
}

class Rating {
  final String source;
  final String value;
  Rating({required this.source, required this.value});
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      source: json['Source'] as String? ?? '',
      value:  json['Value']  as String? ?? '',
    );
  }
}
