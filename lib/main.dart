import 'package:flutter/material.dart';

void main() => runApp(const BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
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
          Editor(
            controlador: _controladorCampoNumeroConta,
            rotulo: "Número da conta",
            dica: "0000",
          ),
          Editor(
            controlador: _controladorCampoValor,
            rotulo: "Valor",
            dica: "0.00",
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
            onPressed: () => _criaTransferencia(context),
            child: const Text("Confirmar"),
          )
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta, date);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController _controlador;
  final String _rotulo;
  final String? _dica;
  final IconData? _icone;

  const Editor(
      {Key? key,
      required TextEditingController controlador,
      required String rotulo,
      String? dica,
      IconData? icone})
      : _controlador = controlador,
        _rotulo = rotulo,
        _dica = dica,
        _icone = icone,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controlador,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: InputDecoration(
          icon: _icone == null ? null : Icon(_icone),
          labelText: _rotulo,
          hintText: _dica,
        ),
        keyboardType: TextInputType.number,
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return FormularioTransferencia();
            }),
          );
          future.then((transferenciaRecebida) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$transferenciaRecebida'),
              ),
            );
          });
        },
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
