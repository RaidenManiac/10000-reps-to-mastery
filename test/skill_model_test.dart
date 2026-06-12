import 'package:flutter_test/flutter_test.dart';
import 'package:ten_thousand_reps_to_mastery/models/skill.dart';

void main() {
  test('calculates progress and remaining reps', () {
    final skill = Skill(
      name: 'Practice',
      currentCount: 2500,
      goal: 10000,
      lastUpdated: DateTime.utc(2026),
    );

    expect(skill.progress, 0.25);
    expect(skill.remaining, 7500);
    expect(skill.isComplete, isFalse);
  });

  test('clamps complete progress and remaining reps', () {
    final skill = Skill(
      name: 'Practice',
      currentCount: 10001,
      goal: 10000,
      lastUpdated: DateTime.utc(2026),
    );

    expect(skill.progress, 1);
    expect(skill.remaining, 0);
    expect(skill.isComplete, isTrue);
  });
}
