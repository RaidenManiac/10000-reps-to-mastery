import 'package:flutter_test/flutter_test.dart';
import 'package:ten_thousand_reps_to_mastery/models/skill.dart';
import 'package:ten_thousand_reps_to_mastery/state/skill_controller.dart';
import 'package:ten_thousand_reps_to_mastery/storage/skill_storage.dart';

void main() {
  test('initializes with default skill when storage is empty', () async {
    final storage = InMemorySkillStorage();
    final controller = SkillController(storage: storage);

    await controller.initialize();

    expect(controller.isLoading, isFalse);
    expect(controller.skill.currentCount, 0);
    expect(controller.skill.goal, Skill.defaultGoal);
  });

  test('increments and persists the current count', () async {
    final storage = InMemorySkillStorage();
    final controller = SkillController(storage: storage);

    await controller.initialize();
    await controller.increment();

    expect(controller.skill.currentCount, 1);
    expect((await storage.loadSkill())?.currentCount, 1);
    expect(controller.canUndo, isTrue);
  });

  test('undo restores the count before the last increment', () async {
    final storage = InMemorySkillStorage();
    final controller = SkillController(storage: storage);

    await controller.initialize();
    await controller.increment();
    await controller.undoLastIncrement();

    expect(controller.skill.currentCount, 0);
    expect((await storage.loadSkill())?.currentCount, 0);
    expect(controller.canUndo, isFalse);
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
