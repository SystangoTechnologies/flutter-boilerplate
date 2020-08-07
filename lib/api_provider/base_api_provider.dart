import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:contact_list_demo/constants/headers.dart';

class BaseAPIProvider {  
  factory BaseAPIProvider() {
    return baseAPIProviderObj;
  }
  
  BaseAPIProvider.privateConstructor();
  static final BaseAPIProvider baseAPIProviderObj = BaseAPIProvider.privateConstructor();

  Future<http.Response> httpGET(dynamic requestUrl) async{
    http.Response httpResponse = await http.get(requestUrl, headers: formDataHeader);  
    return httpResponse;
  }

  Future<http.Response> httpPOST(dynamic requestUrl, {dynamic requestBody, Encoding requestEncoding}) async{
    final http.Response httpResponse = await http.post(requestUrl, headers: formDataHeader, body: requestBody, encoding: requestEncoding);
    return httpResponse;
  }

  Future<http.Response> httpPUT(dynamic requestUrl, dynamic requestBody) async{
    final http.Response httpResponse = await http.put(requestUrl, headers: formDataHeader, body: requestBody,);
    
    return httpResponse;
  }

  Future<http.Response> httpPATCH(dynamic requestUrl, dynamic requestBody) async{
    final http.Response httpResponse = await http.patch(requestUrl, headers: formDataHeader, body: requestBody);
    return httpResponse;
  }

  Future<http.Response> httpDELETE(dynamic requestUrl) async{
    final http.Response httpResponse = await http.delete(requestUrl, headers: formDataHeader);
    return httpResponse;
  }
}