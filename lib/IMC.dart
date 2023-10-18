
import 'dart:math' as math;

class IMC {
  final double weight;
  final double height;

  IMC({required this.weight, required this.height});

  double get imc {
    var result = weight / math.pow(height, 2);
    result = result * 100;
    return result.roundToDouble() / 100;
  }
}
