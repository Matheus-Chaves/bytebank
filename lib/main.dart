import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: const ListaTransferencias(),
        appBar: AppBar(title: const Text("Transferências")),
        floatingActionButton: const FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: null,
        ),
      ),
    ),
  );
}

class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTransferencia(Transferencia(100.56, 1000, "05/2022")),
        ItemTransferencia(Transferencia(1009, 1000, "06/2022")),
        ItemTransferencia(Transferencia(5423, 1000, "07/2022")),
      ],
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(
    this._transferencia,
  ) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transferencia.valorTransferencia.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
        trailing: Text(_transferencia.dataTransferencia),
      ),
    );
  }
}

class Transferencia {
  final double valorTransferencia;
  final int numeroConta;
  final String dataTransferencia;

  Transferencia(
    this.valorTransferencia,
    this.numeroConta,
    this.dataTransferencia,
  );
}
