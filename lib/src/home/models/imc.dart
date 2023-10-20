import 'dart:math';

class IMC {
  IMC({
    this.weigth = 0.0,
    this.heigth = 0.001,
  });

  final double? weigth;
  final double? heigth;

  String calculate() {
    double imc = (weigth! / pow(heigth!, 2));
    String status = _imcStatus(imc);

    return '${imc.toStringAsFixed(1)} - $status';
  }

  String _imcStatus(double imc) {
    if (imc < 16) {
      return 'Magreza grave';
    } else if (imc < 17) {
      return 'Magreza moderada';
    } else if (imc < 18.5) {
      return 'Magreza leve';
    } else if (imc < 25) {
      return 'Saudável';
    } else if (imc < 30) {
      return 'Sobrepeso';
    } else if (imc < 35) {
      return 'Obesidade grau 1';
    } else if (imc < 40) {
      return 'Obesidade grau 2 (severa)';
    } else {
      return 'Obesidade grau 3 (mórbida)';
    }
  }

  IMC copyWith({
    double? weigth,
    double? heigth,
  }) {
    return IMC(
      weigth: weigth ?? this.weigth,
      heigth: heigth ?? this.heigth,
    );
  }
}
