import 'package:fcf_colombia_by_layton/core/widgets/app_sidebar.dart';
import 'package:fcf_colombia_by_layton/features/home/presentation/widgets/home_featured_players.dart';
import 'package:fcf_colombia_by_layton/features/home/presentation/widgets/home_header.dart';
import 'package:fcf_colombia_by_layton/features/home/presentation/widgets/home_last_result.dart';
import 'package:fcf_colombia_by_layton/features/home/presentation/widgets/home_next_match.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fcf_colombia_by_layton/core/widgets/responsive.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobile(context),
      tablet: _buildTablet(context),
      desktop: _buildDesktop(context),
    );
  }

  // ------------------ MOBILE ------------------
  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: AppSidebar(
          selected: "home",
            onItemSelected: (id) {
              context.go("/$id");
            },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("FCF App"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          HomeHeader(),
          SizedBox(height: 20),
          HomeNextMatch(),
          SizedBox(height: 20),
          HomeLastResult(),
          SizedBox(height: 20),
          HomeFeaturedPlayers(),
        ],
      ),
    );
  }

  // ------------------ TABLET ------------------
  Widget _buildTablet(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: const [
          HomeHeader(),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: HomeNextMatch()),
              SizedBox(width: 32),
              Expanded(child: HomeLastResult()),
            ],
          ),
          SizedBox(height: 32),
          HomeFeaturedPlayers(),
        ],
      ),
    );
  }

  // ------------------ DESKTOP ------------------
  Widget _buildDesktop(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          AppSidebar(
            selected: "home",
            onItemSelected: (id) {
              context.go("/$id");
            },
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: const Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(),
                        SizedBox(height: 32),
                        _DesktopCardsRow(),
                        SizedBox(height: 32),
                        HomeFeaturedPlayers(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------ CARDS ROW DESKTOP ------------------

class _DesktopCardsRow extends StatelessWidget {
  const _DesktopCardsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: HomeNextMatch()),
        SizedBox(width: 32),
        Expanded(child: HomeLastResult()),
      ],
    );
  }
}
