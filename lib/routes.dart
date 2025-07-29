import 'package:go_router/go_router.dart';
import 'package:tamasha/ui/screens/anime.dart';
import 'package:tamasha/ui/screens/category.dart';
import 'package:tamasha/ui/screens/home.dart';
import 'package:tamasha/ui/screens/login.dart';
import 'package:tamasha/ui/screens/ranking.dart';
import 'package:tamasha/ui/screens/search.dart';

GoRouter router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(path: "/anime/:animeId", builder: (context, state) => Anime()),
    GoRoute(path: "/home", builder: (context, state) => Home()),
    GoRoute(path: "/category", builder: (context, state) => Category()),
    GoRoute(path: "/rankings", builder: (context, state) => Ranking()),
    GoRoute(path: "/search", builder: (context, state) => Search()),
    GoRoute(path: "/login", builder: (context, state) => Login()),
  ],
);
