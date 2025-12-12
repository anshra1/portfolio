
import 'package:material_design_system/tokens/reference_tokens.dart';
import 'package:material_design_system/tokens/system_tokens.dart';

/// Abstract interface for a theme generator.
/// Implement this class to create a new type of theme generation strategy.
abstract class ThemeGenerator {
  /// Generates a set of [SystemTokens] from a given set of [ReferenceTokens].
  SystemTokens generate({required ReferenceTokens seeds});
}
