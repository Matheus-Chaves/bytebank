import 'dart:convert';

import 'package:http/http.dart';

import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(authority, 'transactions'))
        .timeout(const Duration(seconds: 10));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    // Realizando post e passando o json no body
    // Response irá devolver um json da nova transaction criada
    final Response response =
        await client.post(Uri.http(authority, 'transactions'),
            headers: {
              'Content-type': 'application/json',
              'password': password,
            },
            body: transactionJson);
    if (response.statusCode == 200) {
      // Decodificando o json em um Map
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw _throwHttpError(response);
  }

  Exception _throwHttpError(Response response) {
    return Exception(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed'
  };
}
