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

  getContacts({String query}) async {
    // sink is a way of adding data reactively to the stream
    // by registering a new event
    _contactController.sink.add(await _contactRepository.getAllContacts());
  }

  addContact(Contact contact) async {
    return await _contactRepository.insertContact(contact);
  }

  updateContact(Contact contact, int id) async {
    return await _contactRepository.updateContact(contact, id);
  }

  deleteContactById(int id) async {
    return await _contactRepository.deleteContactById(id);
  }

  dispose() {
    _contactController.close();
  }
}
