import './constants.dart';
import './functions.dart';

/// Está classe pode herdada, mixada ou instânciada
class DartDevUtils {}

extension ImplementObjectUtils on DartDevUtils {
  Constants get constants => Constants.i;
  Functions get functions => Functions.i;
}
