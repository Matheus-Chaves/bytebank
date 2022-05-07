class Transferencia {
  final double valorTransferencia;
  final int numeroConta;
  final DateTime dataTransferencia;

  Transferencia(
    this.valorTransferencia,
    this.numeroConta,
    this.dataTransferencia,
  );

  @override
  String toString() {
    var data = dataTransferencia.toString().replaceAll("00:00:00.000", "");
    return "Transferencia = valor: $valorTransferencia, numero: $numeroConta, data: $data";
  }
}
