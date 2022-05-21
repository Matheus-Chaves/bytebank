import '../components/centered_message.dart';
import '../components/progress.dart';
import '../http/webclient.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

const appBarTitle = "Transactions";

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // essa build será reconstruída quando setState for chamado
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            //break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions =
                    snapshot.data as List<Transaction>;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return ItemTransferencia(transaction);
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return const CenteredMessage(
                "No transactions found",
                icon: Icons.warning,
              );
          }
          return const CenteredMessage('Unknown error');
        },
      ),
    );
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
        title: Text(_transaction.value.toString()),
        subtitle: Text(_transaction.contact.accountNumber.toString()),
        // trailing: Text(_transaction.dataTransferencia
        //     .toString()
        //     .replaceAll("00:00:00.000", "")),
      ),
    );
  }
}
