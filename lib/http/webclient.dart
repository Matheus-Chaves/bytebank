import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

void findAll() async {
  final Response response =
      await get(Uri.http('192.168.0.16:8080', 'transactions'));
  debugPrint(response.body);
}
