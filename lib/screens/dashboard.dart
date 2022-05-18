import 'package:flutter/material.dart';
import 'contacts_list.dart';
import 'transactions_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('images/bytebank_logo.png'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FeatureItem(
                    name: "Transfer",
                    icon: Icons.monetization_on,
                    newPage: ContactsList(),
                  ),
                  _FeatureItem(
                    name: "Transaction Feed",
                    icon: Icons.description,
                    newPage: TransactionsList(),
                  ),
                  const _FeatureItem(
                    name: "Teste",
                    icon: Icons.yard,
                    newPage: null,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Widget? newPage;

  const _FeatureItem(
      {Key? key, required this.name, required this.icon, required this.newPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: InkWell(
          onTap: () {
            if (newPage != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => newPage!,
              ));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(icon, color: Colors.white, size: 32),
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
