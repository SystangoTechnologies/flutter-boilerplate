import 'dart:convert';
import 'package:contact_list_demo/model/contact.dart';

class ContactUtils {
  List<Contact> fromJsonResponse(String response) {
    List<dynamic> data = jsonDecode(response);
    List<Contact> contactList = new List<Contact>();
    for(int i=0; i<data.length; i++) {
        Contact contact = Contact(
        id: data[i]['id'],
        name: data[i]['name'],
        email: data[i]['email'],
        extensions: data[i]['extensions']
        );
        contactList.add(contact);
    }
    return contactList;
  }
}