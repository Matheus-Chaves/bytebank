import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/formulario/formulario.dart';
import 'package:flutter/material.dart';

const tituloAppBar = "Transferências";

class ListaTransferencias extends StatefulWidget {
  ListaTransferencias({Key? key}) : super(key: key);

  final List<Transferencia?> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    // essa build será reconstruída quando setState for chamado
    return Scaffold(
      appBar: AppBar(
        title: const Text(tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice]!;
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const FormularioTransferencia();
            }),
          ).then(
            (transferenciaRecebida) =>
                _atualizarWidget(transferenciaRecebida, context),
          );
        },
      ),
    );
  }

  void _atualizarWidget(
      Transferencia? transferenciaRecebida, BuildContext context) {
    // o bloco abaixo será chamado quando o future for ativado
    // receberá o valor passado onde Navigator.pop for chamado.
    if (transferenciaRecebida != null) {
      setState(() {
        // avisa que a build do Widget atual deverá ser atualizada após os comandos abaixo
        widget._transferencias.add(transferenciaRecebida);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$transferenciaRecebida'),
          ),
        );
      });
    }
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
