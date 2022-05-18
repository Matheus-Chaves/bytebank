import 'contact.dart';

class Transaction {
  final double valorTransferencia;
  final Contact contact;
  final DateTime dataTransferencia;

  Transaction(
    this.valorTransferencia,
    this.contact,
    this.dataTransferencia,
  );

  @override
  String toString() {
    var data = dataTransferencia.toString().replaceAll("00:00:00.000", "");
    return "Transaction -> value: $valorTransferencia, contact: $contact, data: $data";
  }
}
