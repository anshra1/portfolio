
import 'package:equatable/equatable.dart';

/// A class to define the configuration for font scaling.
class FontScalingConfiguration extends Equatable {
  /// The scaling factor for tablet devices.
  final double tabletScaleFactor;

  /// The scaling factor for desktop devices.
  final double desktopScaleFactor;

  /// Creates a new [FontScalingConfiguration] instance.
  const FontScalingConfiguration({
    this.tabletScaleFactor = 1.1,
    this.desktopScaleFactor = 1.2,
  });

  @override
  List<Object?> get props => [tabletScaleFactor, desktopScaleFactor];
}
