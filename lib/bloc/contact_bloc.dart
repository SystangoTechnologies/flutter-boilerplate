import 'package:contact_list_demo/model/contact.dart';
import 'package:contact_list_demo/repository/contact_repository.dart';
import 'dart:async';

class ContactBloc {
  // Get instance of the Repository
  final _contactRepository = ContactRepository();

  // Stream controller is the 'Admin' that manages
  // the state of our stream of data like adding
  // new data, change the state of the stream
  // and broadcast it to observers/subscribers
  final _contactController = StreamController<List<Contact>>.broadcast();

  get contacts => _contactController.stream;

  ContactBloc() {
    getContacts();
  }

  getContacts({String query}) async {
    // sink is a way of adding data reactively to the stream
    // by registering a new event
    _contactController.sink.add(await _contactRepository.getAllContacts(query: query));
  }

  addContact(Contact contact) async {
    await _contactRepository.insertContact(contact);
    getContacts();
  }

  updateContact(Contact contact) async {
    await _contactRepository.updateContact(contact);
    getContacts();
  }

  deleteContactById(int id) async {
    _contactRepository.deleteContactById(id);
    getContacts();
  }

  deleteAllContacts() async {
    _contactRepository.deleteAllContacts();
    getContacts();
  }

  dispose() {
    _contactController.close();
  }
}
