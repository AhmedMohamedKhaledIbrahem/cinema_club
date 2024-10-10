String getAllMoviesApi =
    'https://api.themoviedb.org/3/trending/movie/week?language=en-US&page=';
String getUpComingSoonApi =
    'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=';
String getTopRatedAPi =
    'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=';
String getPopularApi =
    'https://api.themoviedb.org/3/movie/popular?language=en-US&page=';
String movieDetailsByApi = 'https://api.themoviedb.org/3/movie/';
String searchMovieApi = 'https://api.themoviedb.org/3/search/movie?query=';
String genersApi = 'https://api.themoviedb.org/3/genre/movie/list';

String buildMovieSearchApi(String query, int page) {
  return 'https://api.themoviedb.org/3/search/movie?query=$query&language=en-US&page=$page';
}
