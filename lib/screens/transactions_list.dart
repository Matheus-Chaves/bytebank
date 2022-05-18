import '../models/transaction.dart';
import 'formulario/formulario.dart';
import 'package:flutter/material.dart';

const appBarTitle = "Transactions";

class TransactionsList extends StatefulWidget {
  TransactionsList({Key? key}) : super(key: key);

  final List<Transaction?> _transaction = [];

  @override
  State<StatefulWidget> createState() {
    return TransactionsListState();
  }
}

class TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    // essa build será reconstruída quando setState for chamado
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
      ),
      body: ListView.builder(
        itemCount: widget._transaction.length,
        itemBuilder: (context, indice) {
          final transaction = widget._transaction[indice]!;
          return ItemTransferencia(transaction);
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
            (receivedTransaction) =>
                _updateWidget(receivedTransaction, context),
          );
        },
      ),
    );
  }

  void _updateWidget(Transaction? receivedTransaction, BuildContext context) {
    // o bloco abaixo será chamado quando o future for ativado
    // receberá o valor passado onde Navigator.pop for chamado.
    if (receivedTransaction != null) {
      setState(() {
        // avisa que a build do Widget atual deverá ser atualizada após os comandos abaixo
        widget._transaction.add(receivedTransaction);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$receivedTransaction'),
          ),
        );
      });
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transaction _transaction;

  const ItemTransferencia(
    this._transaction,
  ) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.monetization_on), //para centralizar o símbolo
        ),
        title: Text(_transaction.valorTransferencia.toString()),
        subtitle: Text(_transaction.contact.accountNumber.toString()),
        trailing: Text(_transaction.dataTransferencia
            .toString()
            .replaceAll("00:00:00.000", "")),
      ),
    );
  }
}
