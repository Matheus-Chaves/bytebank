import 'package:flutter/material.dart';

void main() {
  // utilizando o runApp com um Widget temos o benefício do hot reload
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  FormularioTransferencia({Key? key}) : super(key: key);

  // para monitorar as edições nos campos de texto
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criando Transferência")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorCampoNumeroConta,
              style: const TextStyle(
                fontSize: 24,
              ),
              decoration: const InputDecoration(
                labelText: "Número da conta",
                hintText: "0000",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorCampoValor,
              style: const TextStyle(
                fontSize: 24,
              ),
              decoration: const InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: "Valor",
                hintText: "0.00",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              debugPrint("Clicou no confirmar");
              final int? numeroConta =
                  int.tryParse(_controladorCampoNumeroConta.text);
              final double? valor =
                  double.tryParse(_controladorCampoValor.text);
              DateTime now = DateTime.now();
              DateTime date = DateTime(now.year, now.month, now.day);

              if (numeroConta != null && valor != null) {
                final transferenciaCriada =
                    Transferencia(valor, numeroConta, date);
                debugPrint("$transferenciaCriada");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$transferenciaCriada'),
                  ),
                );
              }
            },
            child: const Text("Confirmar"),
          )
        ],
      ),
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
          ItemTransferencia(Transferencia(100.56, 1000, DateTime.now())),
          ItemTransferencia(Transferencia(1009, 1000, DateTime.now())),
          ItemTransferencia(Transferencia(5423, 1000, DateTime.now())),
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
        trailing: Text(_transferencia.dataTransferencia
            .toString()
            .replaceAll("00:00:00.000", "")),
      ),
    );
  }
}

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
