import 'package:contact_list_demo/dao/contact_dao.dart';
import 'package:contact_list_demo/model/contact.dart';

class ContactRepository {
  final contactDao = ContactDao();

  Future getAllContacts({String query}) => contactDao.getContacts(query: query);

  Future insertContact(Contact contact) => contactDao.createContact(contact);

  Future updateContact(Contact contact) => contactDao.updateContact(contact);

  Future deleteContactById(int id) => contactDao.deleteContact(id);

  Future deleteAllContacts() => contactDao.deleteAllContacts();
}
