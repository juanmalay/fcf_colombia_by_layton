import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/common/custom_scaffold_with_nav.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/matches/presentation/screens/matches_screen.dart';
import '../../features/matches/presentation/screens/match_detail_screen.dart';
import '../../features/teams/presentation/screens/teams_screen.dart';
import '../../features/teams/presentation/screens/team_detail_screen.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
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
                  final matchId = state.pathParameters['matchId'] ?? '';
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
}
