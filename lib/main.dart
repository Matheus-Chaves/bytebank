import 'screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BytebankApp());
  // save(Transaction(769.0, Contact(0, 'Vanessa', 10000)))
  //     .then((transaction) => print(transaction));
  //findAll().then((value) => print(value));
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //useMaterial3: true,
        //primaryColor: Colors.green[900], //não necessário. ColorScheme faz isso
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green[900],
          secondary: Colors.blueAccent[700],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent[700],
          ),
        ),
      ),
      home: const Dashboard(),
    );
  }
}
