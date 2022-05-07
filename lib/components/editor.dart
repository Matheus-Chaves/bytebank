import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController _controlador;
  final String _rotulo;
  final String? _dica;
  final IconData? _icone;

  const Editor({
    Key? key,
    required TextEditingController controlador,
    required String rotulo,
    String? dica,
    IconData? icone,
  })  : _controlador = controlador,
        _rotulo = rotulo,
        _dica = dica,
        _icone = icone,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controlador,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: InputDecoration(
          icon: _icone == null ? null : Icon(_icone),
          labelText: _rotulo,
          hintText: _dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
