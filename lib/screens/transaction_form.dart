import 'dart:async';

import 'package:uuid/uuid.dart';

import '../components/progress.dart';
import '../components/response_dialog.dart';
import '../components/transaction_auth_dialog.dart';
import '../http/webclients/transaction_webclient.dart';
import '../models/contact.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;
  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  TransactionFormState createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  // cada form deve possuir uma UUID específica
  final String transactionId = const Uuid().v4();
  bool _isTransactionSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _isTransactionSent,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Progress(
                    message: "Sending transaction...",
                  ),
                ),
              ),
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      if (value != null) {
                        final transactionCreated = Transaction(
                          transactionId,
                          value,
                          widget.contact,
                        );
                        showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(onConfirm: (password) {
                              _save(transactionCreated, password, context);
                            });
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    await _send(
      transactionCreated,
      password,
      context,
    );
  }

  Future<void> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    try {
      setState(() {
        _isTransactionSent = true;
      });
      await _webClient.save(transactionCreated, password);
      setState(() {
        _isTransactionSent = false;
      });
      await showDialog(
        context: context,
        builder: (contextDialog) {
          return const SuccessDialog('Successful transaction');
        },
      ).then((value) => Navigator.pop(context));
    } catch (error) {
      if (error is HttpException) {
        _showFailureMessage(context, message: error.message);
      } else if (error is TimeoutException) {
        _showFailureMessage(context,
            message: "Timeout submitting the transaction");
      } else {
        _showFailureMessage(context);
      }
    } finally {
      setState(() {
        _isTransactionSent = false;
      });
    }
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknown Error'}) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return FailureDialog(message);
      },
    );
  }
}
