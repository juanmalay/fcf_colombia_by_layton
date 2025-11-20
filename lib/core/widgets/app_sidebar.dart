import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppSidebar extends StatelessWidget {
  final Function(String) onItemSelected;
  final String selected;

  const AppSidebar({
    super.key,
    required this.onItemSelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF0D0F14), // tono negro elegante
        border: Border(
          right: BorderSide(color: Colors.white12, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO / TÍTULO
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "FCF App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Menú
          _menuItem(context,
            icon: Icons.sports_soccer,
            label: "Inicio",
            id: "home",
          ),
          _menuItem(context,
            icon: Icons.calendar_month,
            label: "Partidos",
            id: "matches",
          ),
          _menuItem(context,
            icon: Icons.people_alt,
            label: "Jugadores",
            id: "players",
          ),
          _menuItem(context,
            icon: Icons.newspaper,
            label: "Noticias",
            id: "news",
          ),
          _menuItem(context,
            icon: Icons.photo_library,
            label: "Multimedia",
            id: "media",
          ),
          _menuItem(context,
            icon: Icons.history_edu,
            label: "Configuracion",
            id: "settings",
          ),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context,{
    required IconData icon,
    required String label,
    required String id,
  }) {
    final bool isActive = selected == id;

    return InkWell(
      onTap: () => _navigate(context, id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white10,
                border: Border(
                  left: BorderSide(color: Colors.yellow.shade600, width: 4),
                ),
              )
            : null,
        child: Row(
          children: [
            Icon(icon,
                size: 22, color: isActive ? Colors.yellow : Colors.white70),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isActive ? Colors.white : Colors.white70,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, String id) {
    switch (id) {
      case "home":
        context.go("/");
        break;
      case "matches":
        context.go("/matches");
        break;
      case "players":
        context.go("/players");
        break;
      case "news":
        context.go("/news");
        break;
      case "media":
        context.go("/media");
        break;
      case "history":
        context.go("/history");
        break;
    }
  }
}
