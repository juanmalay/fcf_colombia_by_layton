import 'package:fcf_colombia_by_layton/features/matches/presentation/widgets/match_card.dart';
import 'package:flutter/material.dart';
import '../../data/matches_local_service.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List nextMatches = [];
  List results = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await MatchesLocalService.loadMatches();

    setState(() {
      nextMatches = data["nextMatches"];
      results = data["results"];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Partidos"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "Próximos Partidos",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                ...nextMatches.map((m) => MatchCard(
                      homeTeamCode: m["homeCode"],
                      homeTeamName: m["homeTeam"],
                      awayTeamCode: m["awayCode"],
                      awayTeamName: m["awayTeam"],
                      date: m["date"],
                      hour: m["time"],
                      isNext: true,
                    )),

                const SizedBox(height: 32),
                const Text(
                  "Resultados Recientes",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                ...results.map((m) => MatchCard(
                      homeTeamCode: m["homeCode"],
                      homeTeamName: m["homeTeam"],
                      awayTeamCode: m["awayCode"],
                      awayTeamName: m["awayTeam"],
                      homeScore: m["homeScore"],
                      awayScore: m["awayScore"],
                    )),
              ],
            ),
    );
  }
}
