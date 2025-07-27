// import 'package:flutter/widgets.dart';
// import 'package:tamasha/ui/screens/home.dart';
// import 'package:tamasha/ui/screens/category.dart';
// import 'package:tamasha/ui/screens/login.dart';
// import 'package:tamasha/ui/screens/ranking.dart';
// import 'package:tamasha/ui/screens/search.dart';
// import 'package:tamasha/ui/screens/anime.dart';
// import 'package:tamasha/ui/widgets/banner.dart' as banner;

// Map<String, WidgetBuilder> routes = {
//   "/home": (context) => Home(),
//   "/category": (context) => Category(),
//   "/rankings": (context) => Ranking(),
//   "/search": (context) => Search(),
//   "/anime": (context) => Anime(animeInstance: banner.animeInfo),
//   "/login": (context) => Login(),
// };

import 'package:go_router/go_router.dart';
import 'package:tamasha/ui/screens/anime.dart';
import 'package:tamasha/ui/screens/category.dart';
import 'package:tamasha/ui/screens/home.dart';
import 'package:tamasha/ui/screens/login.dart';
import 'package:tamasha/ui/screens/ranking.dart';
import 'package:tamasha/ui/screens/search.dart';
import 'package:tamasha/ui/widgets/banner.dart' as banner;

GoRouter router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(path: "/home", builder: (context, state) => Home()),
    GoRoute(path: "/category", builder: (context, state) => Category()),
    GoRoute(path: "/rankings", builder: (context, state) => Ranking()),
    GoRoute(path: "/search", builder: (context, state) => Search()),
    GoRoute(
      path: "/anime",
      builder: (context, state) => Anime(animeInstance: banner.animeInfo),
    ),
    GoRoute(path: "/login", builder: (context, state) => Login()),
  ],
);
