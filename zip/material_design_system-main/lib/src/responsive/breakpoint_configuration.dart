
import 'package:equatable/equatable.dart';

/// A class to define the breakpoints for responsive design.
class BreakpointConfiguration extends Equatable {
  /// The maximum width for a screen to be considered mobile.
  final double mobile;

  /// The maximum width for a screen to be considered tablet.
  final double tablet;

  /// The maximum width for a screen to be considered desktop.
  /// This is used for designs that may have a maximum width.
  final double desktop;

  /// Creates a new [BreakpointConfiguration] instance.
  const BreakpointConfiguration({
    this.mobile = 600,
    this.tablet = 1200,
    this.desktop = 1920,
  });

  @override
  List<Object?> get props => [mobile, tablet, desktop];
}
