import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/home/presentation/screens/home_screen.dart';
import 'features/matches/presentation/screens/matches_screen.dart';
import 'features/matches/presentation/screens/match_detail_screen.dart';
import 'features/teams/presentation/screens/teams_screen.dart';
import 'features/teams/presentation/screens/team_detail_screen.dart';
import 'features/players/presentation/screens/players_screen.dart';
import 'features/tournaments/presentation/screens/tournaments_screen.dart';
import 'features/news/presentation/screens/news_screen.dart';
import 'features/multimedia/presentation/screens/multimedia_screen.dart';
import 'features/favorites/presentation/screens/favorites_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/matches',
        name: 'matches',
        builder: (context, state) => const MatchesScreen(),
        routes: [
          GoRoute(
            path: ':matchId',
            name: 'match_detail',
            builder: (context, state) {
              final matchId = state.pathParameters['matchId'] ?? '';
              return MatchDetailScreen(matchId: matchId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/teams',
        name: 'teams',
        builder: (context, state) => const TeamsScreen(),
        // Rutas anidadas para detalles de selecciones nacionales
        routes: [
          GoRoute(
            path: ':teamId',
            name: 'team_detail',
            builder: (context, state) {
              final teamId = state.pathParameters['teamId'] ?? '';
              return TeamDetailScreen(teamId: teamId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/players',
        name: 'players',
        builder: (context, state) => const PlayersScreen(),
      ),
      GoRoute(
        path: '/tournaments',
        name: 'tournaments',
        builder: (context, state) => const TournamentsScreen(),
      ),
      GoRoute(
        path: '/news',
        name: 'news',
        builder: (context, state) => const NewsScreen(),
      ),
      GoRoute(
        path: '/multimedia',
        name: 'multimedia',
        builder: (context, state) => const MultimediaScreen(),
      ),
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}

