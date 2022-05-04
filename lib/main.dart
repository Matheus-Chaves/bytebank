import 'package:flutter/material.dart';

void main() {
  // utilizando o runApp com um Widget temos o benefício do hot reload
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criando Transferência")),
      body: const Text("Oba, hot reload pegando!"),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transferências")),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.56, 1000, "05/2022")),
          ItemTransferencia(Transferencia(1009, 1000, "06/2022")),
          ItemTransferencia(Transferencia(5423, 1000, "07/2022")),
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
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
        leading: const SizedBox(
          child: Icon(Icons.monetization_on),
          height: double.infinity, //para centralizar o símbolo
        ),
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
