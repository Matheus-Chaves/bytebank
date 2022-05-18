import 'package:flutter/material.dart';
import '../database/dao/contact_dao.dart';
import '../models/contact.dart';
import 'contact_form.dart';

class ContactsList extends StatefulWidget {
  ContactsList({Key? key}) : super(key: key);
  final ContactDao _dao = ContactDao();

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer"),
      ),
      body: FutureBuilder<List<Contact>>(
        //importante definir o tipo do Widget, pois assim ele limita o que pode ser escrito no initialData
        initialData: const [], // devolve lista vazia de início (enquanto não achou nada)
        future: widget._dao.findAll(),
        builder: (context, snapshot) {
          //snapshot is responsible for retrieving the data
          //connectionState indica o estado dos dados do snapshot
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // esse estado é chamado quando o FutureBuilder ainda não começou a processar o seu atributo future: findAll()
              // utilizado geralmente com um botão que, ao receber um click, começa o método
              break;
            case ConnectionState.waiting:
              // estado que é chamado enquanto o future começou a processar, mas ainda não gerou retorno algum
              // utilizado geralmente com tela de loading
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading')
                  ],
                ),
              );
            case ConnectionState.active:
              // indica como está o estado da conexão ativa
              // utilizado geralmente com downloads, mostrando a porcentagem conforme vai baixando
              break;
            case ConnectionState.done:
              // chamado quando acaba o future
              // utilizado geralmente para devolver um retorno visual
              final List<Contact> contacts = snapshot.data as List<Contact>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(contact);
                },
                itemCount: contacts.length,
              );
          }
          // caso nenhum dos switch case acima ocorram (o que é impossível, exceto se o ConnectionState incluir mais estados)
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const ContactForm(),
              ))
              .then((newContact) => setState(() {}));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
