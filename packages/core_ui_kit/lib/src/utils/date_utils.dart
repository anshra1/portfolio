class AppDateUtils {
  static String format(DateTime date) => date.toIso8601String().split('T').first;
}
