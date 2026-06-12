import 'package:flutter/material.dart';

import '../state/skill_controller.dart';

class MasteryScreen extends StatelessWidget {
  const MasteryScreen({required this.controller, super.key});

  final SkillController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final skill = controller.skill;
        final textTheme = Theme.of(context).textTheme;
        final colorScheme = Theme.of(context).colorScheme;

        return Scaffold(
          appBar: AppBar(
            title: const Text('10,000 Reps'),
            actions: [
              IconButton(
                tooltip: 'Undo last rep',
                onPressed: controller.canUndo
                    ? () {
                        controller.undoLastIncrement();
                      }
                    : null,
                icon: const Icon(Icons.undo),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    skill.name,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${skill.currentCount}',
                    style: textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'of ${skill.goal} reps',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      minHeight: 12,
                      value: skill.progress,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    skill.isComplete
                        ? 'Goal reached'
                        : '${skill.remaining} reps remaining',
                    style: textTheme.titleMedium,
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: () {
                      controller.increment();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('+1 Rep'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(64),
                      textStyle: textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
