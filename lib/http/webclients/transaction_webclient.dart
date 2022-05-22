import 'dart:convert';

import 'package:http/http.dart';

import '../../models/contact.dart';
import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(authority, 'transactions'))
        .timeout(const Duration(seconds: 10));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in decodedJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    // transformando em Map para ser convertido em json
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber
      }
    };
    // Transformamos o Map no formato Json e o guardamos dentro de uma String
    final String transactionJson = jsonEncode(transactionMap);

    // Realizando post e passando o json no body
    // Response irá devolver um json da nova transaction criada
    final Response response =
        await client.post(Uri.http(authority, 'transactions'),
            headers: {
              'Content-type': 'application/json',
              'password': '1000',
            },
            body: transactionJson);
    // Decodificando o json em um Map
    Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> contactJson = json['contact'];

    // Convertendo o Map para uma variável do tipo Transaction
    return Transaction(
      json['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
  }
}
