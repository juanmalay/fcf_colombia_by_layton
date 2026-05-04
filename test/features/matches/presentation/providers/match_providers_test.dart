import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:fcf_colombia_by_layton/features/matches/presentation/providers/match_providers.dart';
import 'package:fcf_colombia_by_layton/features/matches/domain/repositories/match_repository.dart';
import 'package:fcf_colombia_by_layton/features/matches/domain/entities/match.dart';

class MockMatchRepository extends Mock implements MatchRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Inicializar bindings

  group('MatchProviders', () {
    late MockMatchRepository mockRepository;

    setUp(() {
      mockRepository = MockMatchRepository();
    });

    test('upcomingMatchesProvider should fetch data', () async {
      when(mockRepository.getUpcomingMatches()).thenAnswer((_) async => <Match>[]);

      final container = ProviderContainer(overrides: [
        upcomingMatchesProvider.overrideWith(() => UpcomingMatchesNotifier()),
      ]);
      addTearDown(container.dispose);

      final result = await container.read(upcomingMatchesProvider.future);

      expect(result.isNotEmpty, true);
    });

    test('recentMatchesProvider should fetch data', () async {
      when(mockRepository.getRecentMatches()).thenAnswer((_) async => <Match>[]);

      final container = ProviderContainer(overrides: [
        recentMatchesProvider.overrideWith(() => RecentMatchesNotifier()),
      ]);
      addTearDown(container.dispose);

      final result = await container.read(recentMatchesProvider.future);

      expect(result.isNotEmpty, true);
    });
  });
}