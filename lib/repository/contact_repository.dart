import 'package:contact_list_demo/model/contact.dart';
import 'package:contact_list_demo/api_provider/contact_api_provider.dart';

class ContactRepository {
  final contactApiProvider = ContactApiProvider();

  Future getAllContacts() => contactApiProvider.getContacts();

  Future insertContact(Contact contact) => contactApiProvider.addContact(contact);

  Future updateContact(Contact contact, int id) => contactApiProvider.updateContact(contact, id);

  Future deleteContactById(int id) => contactApiProvider.deleteContact(id);
}
