import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ten_thousand_reps_to_mastery/main.dart';
import 'package:ten_thousand_reps_to_mastery/models/skill.dart';
import 'package:ten_thousand_reps_to_mastery/state/skill_controller.dart';
import 'package:ten_thousand_reps_to_mastery/storage/skill_storage.dart';

void main() {
  testWidgets('increments and undoes a rep from the main screen', (
    WidgetTester tester,
  ) async {
    final controller = SkillController(storage: InMemorySkillStorage());
    await controller.initialize();

    await tester.pumpWidget(RepsApp(controller: controller));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('10000 reps remaining'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('9999 reps remaining'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.undo));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('10000 reps remaining'), findsOneWidget);
  });
}

class InMemorySkillStorage implements SkillStorage {
  Skill? _skill;

  @override
  Future<Skill?> loadSkill() async => _skill;

  @override
  Future<void> saveSkill(Skill skill) async {
    _skill = skill;
  }
}
