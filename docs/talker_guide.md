# Talker Documentation Guide

Talker is an advanced error handler and logger for Dart and Flutter applications. It is designed to help you understand where errors occur in the shortest possible time.

## 🚀 Core Features
- **Universal Compatibility:** Works with any state management (BLoC, Riverpod, etc.).
- **In-App Logs:** View logs, errors, and HTTP requests directly on the device via `TalkerScreen`.
- **Global Error Handling:** Catch and handle uncaught exceptions across the entire app.
- **Modular Integrations:** Built-in support for Dio, BLoC, Riverpod, and more.
- **Customization:** Fully customizable log types, colors, and titles.

---

## 📦 Package Ecosystem

| Package | Description |
| :--- | :--- |
| `talker` | Main Dart package for logging and error handling. |
| `talker_flutter` | Flutter extensions (UI screens, Route Observers, Alerts). |
| `talker_bloc_logger` | Observer for BLoC state management logging. |
| `talker_dio_logger` | Interceptor for Dio HTTP logging. |
| `talker_riverpod_logger` | Observer for Riverpod logging. |

---

## 🛠 Basic Usage

### Initialization
For Flutter apps, always use `TalkerFlutter.init()` for optimal logging:
```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();
```

### Logging
```dart
talker.info('App started');
talker.warning('Low memory detected');
talker.critical('Database connection failed');

// Handling Exceptions
try {
  throw Exception('Something went wrong');
} catch (e, st) {
  talker.handle(e, st, 'Error while processing data');
}
```

---

## 🎨 Advanced Customization

### Custom Log Types
You can create your own log types by extending `TalkerLog`:
```dart
class MyCustomLog extends TalkerLog {
  MyCustomLog(String super.message);

  @override
  String get title => 'CUSTOM';

  @override
  AnsiPen get pen => AnsiPen()..yellow();
}

talker.logCustom(MyCustomLog('Custom message'));
```

### Changing Default Colors
```dart
final talker = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.error.key: AnsiPen()..green(), // Change error color to green
    },
  ),
);
```

---

## 🖥 Flutter Specifics

### TalkerScreen
Show the debugging dashboard in your app:
```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

### TalkerRouteObserver
Automatically log every screen navigation:
```dart
MaterialApp(
  navigatorObservers: [
    TalkerRouteObserver(talker),
  ],
)
```

### TalkerWrapper
Wrap your application to show automatic error alerts (Snackbars/Dialogs):
```dart
TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(enableErrorAlerts: true),
  child: const MyApp(),
)
```

---

## 🔗 Integrations

### BLoC Observer
```dart
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

Bloc.observer = TalkerBlocObserver(
  talker: talker,
  settings: const TalkerBlocLoggerSettings(
    printChanges: true,
    printTransitions: true,
  ),
);
```

### Dio Interceptor
```dart
import 'package:talker_dio_logger/talker_dio_logger.dart';

final dio = Dio();
dio.interceptors.add(TalkerDioLogger(talker: talker));
```
