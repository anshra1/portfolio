import 'package:flutter/material.dart';
import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/services/talker_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerShowcaseScreen extends StatelessWidget {
  const TalkerShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final talkerService = getIt<TalkerService>();
    final talker = talkerService.talker;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Talker Showcase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.monitor_heart),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => TalkerScreen(talker: talker),
              ),
            ),
            tooltip: 'Open Talker Console',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SectionHeader(title: 'Basic Logging'),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => talker.info('This is an INFO log'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    'Info',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => talker.warning('This is a WARNING log'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text(
                    'Warning',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => talker.error('This is an ERROR log'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'Error',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => talker.debug('This is a DEBUG log'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    'Debug',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => talker.verbose('This is a VERBOSE log'),
                  child: const Text('Verbose'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            const _SectionHeader(title: 'Exception Handling'),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    try {
                      throw Exception('Test Exception from Showcase');
                    } on Exception catch (e, st) {
                      talker.handle(e, st, 'Caught an exception manually');
                    }
                  },
                  child: const Text('Handle Exception'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // This will be caught by the global error handler in main.dart
                    throw ArgumentError('Uncaught Argument Error!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[100],
                  ),
                  child: const Text('Throw Uncaught Error'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const _SectionHeader(title: 'Pizza Order Example'),
            ElevatedButton(
              onPressed: () {
                talker
                  ..warning('The pizza is over 😥')
                  ..debug('Thinking about order new one 🤔');

                try {
                  throw Exception('The restaurant is closed ❌');
                } on Exception catch (e, st) {
                  talker.handle(e, st);
                }

                talker
                  ..info('Ordering from other restaurant...')
                  ..info('Payment started...');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Run Pizza Order Story'),
            ),
            const SizedBox(height: 24),

            const _SectionHeader(title: 'Custom Logs'),
            ElevatedButton(
              onPressed: () {
                talker.logCustom(
                  HttpLog(
                    'GET https://api.example.com/users/1',
                    response: {'id': 1, 'name': 'John Doe'},
                    statusCode: 200,
                  ),
                );
              },
              child: const Text('Log Fake HTTP Request'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                talker.log(
                  'Custom colored message',
                  pen: AnsiPen()..xterm(49),
                );
              },
              child: const Text('Log with Custom Color'),
            ),
            const SizedBox(height: 48),

            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => TalkerScreen(talker: talker),
                  ),
                ),
                icon: const Icon(Icons.monitor_heart),
                label: const Text('OPEN TALKER SCREEN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Custom Log Class Example
class HttpLog extends TalkerLog {
  HttpLog(
    super.message, {
    this.response,
    this.statusCode,
  });

  final dynamic response;
  final int? statusCode;

  @override
  String get title => 'HTTP';

  @override
  AnsiPen get pen => AnsiPen()..xterm(99); // Purple color

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    return '$title | $message | Status: $statusCode | Data: $response';
  }
}

