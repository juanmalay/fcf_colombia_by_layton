import 'package:flutter/material.dart';
import 'package:fcf_colombia_by_layton/core/config/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.yellow,
            AppColors.red.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // TEXTO
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selección Colombia",
                  style: TextStyle(
                    fontSize: 26,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Noticias, partidos, jugadores y más",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // LOGO
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.black.withOpacity(0.1),
            child: const Icon(
              Icons.sports_soccer,
              size: 40,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
