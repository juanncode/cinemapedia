import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? '';
  static String baseUrl = dotenv.env['URL_BASE_MOVIE'] ?? '';
}
