import 'dart:async';
import 'package:contact_list_demo/database/contact_database.dart';
import 'package:contact_list_demo/model/contact.dart';

class ContactDao {
  final dbProvider = DatabaseProvider.dbProvider;

  /*
  Adds new Contact record
  */
  Future<int> createContact(Contact contact) async {
    final db = await dbProvider.database;
    var result = db.insert(contactTABLE, contact.toDatabaseJson());
    return result;
  }

  /*
  Get All Contact items
  Searches if query string was passed
  */
  Future<List<Contact>> getContacts({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(contactTABLE,
            columns: columns,
            where: 'name LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(contactTABLE, columns: columns);
    }

    List<Contact> contacts = result.isNotEmpty
        ? result.map((item) => Contact.fromDatabaseJson(item)).toList()
        : [];
    return contacts;
  }

  /*
  Update Contact record
  */
  Future<int> updateContact(Contact contact) async {
    final db = await dbProvider.database;

    var result = await db.update(contactTABLE, contact.toDatabaseJson(),
        where: "id = ?", whereArgs: [contact.id]);

    return result;
  }

  /*
  Delete Contact record
  */
  Future<int> deleteContact(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(contactTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  /*
  We are not going to use this in the demo
  */
  Future deleteAllContacts() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      contactTABLE,
    );

    return result;
  }
}
