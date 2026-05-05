import 'package:flutter/material.dart';
import 'custom_bottom_nav.dart';

/// Tipo de tab para la navegación principal
enum MainTab { home, matches, teams, explore, favorites, settings }

/// Extension para obtener detalles del tab
extension MainTabX on MainTab {
  String get label {
    switch (this) {
      case MainTab.home:
        return 'Inicio';
      case MainTab.matches:
        return 'Partidos';
      case MainTab.teams:
        return 'Selecciones';
      case MainTab.explore:
        return 'Explorar';
      case MainTab.favorites:
        return 'Favoritos';
      case MainTab.settings:
        return 'Ajustes';
    }
  }

  IconData get icon {
    switch (this) {
      case MainTab.home:
        return Icons.home;
      case MainTab.matches:
        return Icons.sports_soccer;
      case MainTab.teams:
        return Icons.groups;
      case MainTab.explore:
        return Icons.explore;
      case MainTab.favorites:
        return Icons.favorite;
      case MainTab.settings:
        return Icons.settings;
    }
  }
}

/// Scaffold con navegación por tabs persistente
class CustomScaffoldWithNav extends StatefulWidget {
  final Widget body;
  final MainTab initialTab;
  final ValueChanged<MainTab> onTabChanged;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const CustomScaffoldWithNav({
    super.key,
    required this.body,
    this.initialTab = MainTab.home,
    required this.onTabChanged,
    this.appBar,
    this.backgroundColor,
  });

  @override
  State<CustomScaffoldWithNav> createState() => _CustomScaffoldWithNavState();
}

class _CustomScaffoldWithNavState extends State<CustomScaffoldWithNav> {
  late MainTab _currentTab;

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
  }

  void _handleTabChange(int index) {
    final newTab = MainTab.values[index];
    if (_currentTab != newTab) {
      setState(() => _currentTab = newTab);
      widget.onTabChanged(newTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: widget.body,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentTab.index,
        onChanged: _handleTabChange,
        items: MainTab.values
            .map((tab) => BottomNavItem(icon: tab.icon, label: tab.label))
            .toList(),
      ),
    );
  }
}
