import '../../components/editor.dart';
import '../../models/contact.dart';
import '../../models/transaction.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = "Criando Transferência";
const _rotuloCampoNumeroConta = "Número da conta";
const _dicaCampoNumeroConta = "0000";
const _rotuloCampoValor = "Valor";
const _dicaCampoValor = "0.00";
const _textoBotaoConfirmar = "Confirmar";

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  // para monitorar as edições nos campos de texto
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => _criaTransferencia(context),
              child: const Text(_textoBotaoConfirmar),
            )
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada =
          Transaction(valor, Contact(0, "", numeroConta));
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
