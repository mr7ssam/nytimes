# NyTimes - Most Popualr

**Used patters**:

- BLoC.
- Clean Architecture Layers (feature first approach).
- Multi Packages (bootstrap - core - design - network) using [Melos](https://melos.invertase.dev/getting-started) (Mono Repo).

Project structure highly inspire by VGV: https://verygood.ventures/blog/very-good-flutter-architecture?utm_source=linkedin&utm_medium=social&utm_campaign=app_architecture

Lint rules from **Flutter Linter**

### Project structure:

```
├─ lib
│  ├─ app
│  │  ├─ most_popular
│  │  │  ├─ application
│  │  │  ├─ data
│  │  │  ├─ domain
│  │  │  └─ presentation
│  │  └─ router
│  ├─ app.dart
│  ├─ common
│  ├─ locator
│  ├─ main.dart
│  └─ providers.dart
├─ melos.yaml
├─ packages
│  ├─ bootstrap
│  ├─ core
│  ├─ design
│  └─ network
├─ pubspec.yaml
├─ report.json // test report will saved here
└─ test
   ├─ most_popular_bloc_test.dart
   └─ most_popular_remote_test.dart
```

## Main Dependences:

1. **Flutter BLoC** for State Management.
2. **Go Router** (Routing package use nav 2.0).
3. **Get It** (Service Locater and Dependencies container).
4. **Dio** (Http Client).
5. **BLoC Test**.
6. **Http Mock Adapter** for testing.

## Scripts:

```yaml
scripts:
  analyze:
    run: melos exec -- flutter analyze .
    description: Run `dart analyze` in all packages.

  format: melos exec -- "flutter format ."

  fix_hints: melos exec -- "dart fix —apply ."

  flutter_test_report: flutter test --reporter  json  | tojunit --output report.json

  flutter_test: flutter test

  build_runner:
    run: |
      melos exec --depends-on="build_runner" --  $runner
    env:
      runner: flutter pub run build_runner build --delete-conflicting-outputs
      
  build_relese:
    run: flutter build apk
```

ex: `melos format .`

### Notes:

1. Test report saved in report.json file.
2. You can find all scripts and run them from android studio or VS Code in **melos.yaml** file.
3. Run this before run report test script `dart pub global activate junitreport` if  **junitreport** is note active.