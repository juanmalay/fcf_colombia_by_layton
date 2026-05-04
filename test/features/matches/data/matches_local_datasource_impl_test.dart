import 'package:flutter_test/flutter_test.dart';
import 'package:fcf_colombia_by_layton/features/matches/data/datasources/matches_local_datasource_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Inicializar bindings

  group('MatchesLocalDataSourceImpl', () {
    late MatchesLocalDataSourceImpl dataSource;

    setUp(() {
      dataSource = MatchesLocalDataSourceImpl();
    });

    test('should load seed data correctly', () async {
      final hasUpcoming = await dataSource.hasMatches('upcoming_matches');
      final hasResults = await dataSource.hasMatches('recent_matches');

      expect(hasUpcoming, true);
      expect(hasResults, true);
    });

    test('should retrieve matches from cache', () async {
      final matches = await dataSource.getMatches('upcoming_matches');

      expect(matches.isNotEmpty, true);
    });
  });
}