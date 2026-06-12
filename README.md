# 10,000 Reps to Mastery

A local-first Flutter app for tracking mastery through repetitions instead of
time. The MVP tracks one skill with a default goal of 10,000 reps.

## MVP Scope

Implemented:

- Single skill tracker
- Default goal of 10,000 reps
- Fast +1 rep action
- Undo last increment
- Progress bar
- Remaining reps display
- Local persistence
- Offline-first behavior
- iOS and Android from one Flutter codebase

Intentionally not implemented:

- Authentication
- Cloud sync
- Social features
- Analytics
- Multiple skills
- Streaks
- Gamification
- Premium features

## Architecture

The app is split into three small layers:

- UI layer: `lib/screens/mastery_screen.dart`
- State management layer: `lib/state/skill_controller.dart`
- Local storage layer: `lib/storage/skill_storage.dart`

The domain model lives in `lib/models/skill.dart`.

`SkillController` uses `ChangeNotifier` because the MVP has one focused state
object and does not need a heavier state-management dependency yet. Storage is
behind the `SkillStorage` interface so the app can later move from
`SharedPreferences` to a richer local database without rewriting the UI.

## Data Model

```dart
class Skill {
  final String name;
  final int currentCount;
  final int goal;
  final DateTime lastUpdated;
}
```

## Setup

Prerequisites:

- Flutter 3.44.1 or newer on the stable channel
- Dart 3.12.1 or newer
- Xcode for iOS builds
- Android Studio or Android SDK for Android builds

Install dependencies:

```bash
flutter pub get
```

Run checks:

```bash
flutter analyze
flutter test
```

Run the app:

```bash
flutter run
```

## Development Process

Branch strategy:

- `main` stays deployable and runnable.
- Future work should use short-lived feature branches named
  `feature/<scope>` or `fix/<scope>`.
- Each completed milestone gets a logical commit.

Current milestones:

1. Initialize Flutter project.
2. Implement single-skill reps tracker.
3. Document setup and architecture.

## Repository Status

This repository contains a working MVP. The app persists the current skill
locally and remains useful offline by default.
