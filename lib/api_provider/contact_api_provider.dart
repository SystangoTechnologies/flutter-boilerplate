import 'dart:async';
import 'dart:convert';
import 'package:contact_list_demo/model/contact.dart';
import 'package:contact_list_demo/utils/contact_utils.dart';
import 'package:contact_list_demo/api_provider/base_api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:contact_list_demo/constants/endpoints.dart';
import 'package:contact_list_demo/utils/guid_utils.dart';

class ContactApiProvider {
  BaseAPIProvider baseAPIProvider = BaseAPIProvider();
  ContactUtils contactUtils = ContactUtils();
  final String guid = GUIDUtils.guid;

  Future<bool>  addContact(Contact contact) async {
    Map<String, String> reqBody = {
      'name': contact.name,
      'email': contact.email
    };
    final requestBody = jsonEncode(reqBody);
    final String addContactAPI = '$API_ENDPOINT/$guid/contacts';
    final http.Response response = await baseAPIProvider.httpPOST(addContactAPI, requestBody: requestBody);
    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Contact>> getContacts() async {
    final String getContactsAPIUrl = '$API_ENDPOINT/$guid/contacts';
    final http.Response response = await baseAPIProvider.httpGET(getContactsAPIUrl);
    if(response.statusCode == 200) {
      return contactUtils.fromJsonResponse(response.body);
    } else {
      return [];
    }
  }

  Future<bool> updateContact(Contact contact, int id) async {
    Map<String, dynamic> reqBody = {
      'name': contact.name,
      'email': contact.email,
      'extensions': contact.extensions
    };
    final requestBody = jsonEncode(reqBody);
    final String updateContactAPIUrl = '$API_ENDPOINT/$guid/contacts/$id';
    final http.Response response = await baseAPIProvider.httpPOST(updateContactAPIUrl, requestBody: requestBody);
    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteContact(int id) async {
    final String deleteContactAPIUrl = '$API_ENDPOINT/$guid/contacts/$id';
    final http.Response response = await baseAPIProvider.httpDELETE(deleteContactAPIUrl);
    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
