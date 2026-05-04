import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/common/custom_scaffold_with_nav.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/matches/presentation/screens/matches_screen.dart';
import '../../features/matches/presentation/screens/match_detail_screen.dart';
import '../../features/teams/presentation/screens/teams_screen.dart';
import '../../features/teams/presentation/screens/team_detail_screen.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/players/presentation/screens/players_screen.dart';
import '../../features/tournaments/presentation/screens/tournaments_screen.dart';
import '../../features/news/presentation/screens/news_screen.dart';
import '../../features/multimedia/presentation/screens/multimedia_screen.dart';
import '../../features/favorites/presentation/screens/favorites_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

/// Rutas disponibles en la aplicación
class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      // SHELL ROUTE: Navegación por tabs con bottom navigation persistente
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          // Obtener el tab actual basado en la ruta
          final tab = _getTabFromRoute(state.uri.path);
          return CustomScaffoldWithNav(
            initialTab: tab,
            body: child,
            onTabChanged: (newTab) {
              _navigateToTab(context, newTab);
            },
          );
        },
        routes: [
          // TAB 1: HOME
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),

          // TAB 2: MATCHES
          GoRoute(
            path: '/matches',
            name: 'matches',
            builder: (context, state) => const MatchesScreen(),
            routes: [
              GoRoute(
                path: ':matchId',
                name: 'match_detail',
                builder: (context, state) {
                  final String? matchId = state.pathParameters['matchId'];
                  if (matchId == null) {
                    throw Exception('matchId es requerido');
                  }
                  return MatchDetailScreen(matchId: matchId);
                },
              ),
            ],
          ),

          // TAB 3: TEAMS
          GoRoute(
            path: '/teams',
            name: 'teams',
            builder: (context, state) => const TeamsScreen(),
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

          // TAB 4: EXPLORE
          GoRoute(
            path: '/explore',
            name: 'explore',
            builder: (context, state) => const ExploreScreen(),
          ),

          // EXPLORE CHILD DESTINATIONS
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

          // TAB 5: FAVORITES
          GoRoute(
            path: '/favorites',
            name: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),

          // TAB 6: SETTINGS
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );

  /// Obtener tab actual basado en la ruta
  static MainTab _getTabFromRoute(String path) {
    if (path.contains('/home')) return MainTab.home;
    if (path.contains('/matches')) return MainTab.matches;
    if (path.contains('/teams')) return MainTab.teams;
    if (path.contains('/explore')) return MainTab.explore;
    if (path.contains('/players')) return MainTab.explore;
    if (path.contains('/tournaments')) return MainTab.explore;
    if (path.contains('/news')) return MainTab.explore;
    if (path.contains('/multimedia')) return MainTab.explore;
    if (path.contains('/favorites')) return MainTab.favorites;
    if (path.contains('/settings')) return MainTab.settings;
    return MainTab.home;
  }

  /// Navegar a una pestaña
  static void _navigateToTab(BuildContext context, MainTab tab) {
    final path = switch (tab) {
      MainTab.home => '/home',
      MainTab.matches => '/matches',
      MainTab.teams => '/teams',
      MainTab.explore => '/explore',
      MainTab.favorites => '/favorites',
      MainTab.settings => '/settings',
    };
    context.go(path);
  }

  /// Ruta para detalles de partidos
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/matchDetail':
        final matchId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MatchDetailScreen(matchId: matchId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Ruta no definida')),
          ),
        );
    }
  }
}
