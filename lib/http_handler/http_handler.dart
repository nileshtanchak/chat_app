import 'dart:convert';

import 'package:first_project_in_mac/model/auth_models/registration_model.dart';
import 'package:http/http.dart' as http;

class HttpHandler {
  static String? token;
  static Map<String, String> getHeaders() {
    if (token != "null" || token != "") {
      return {
        "content-type": "application/json",
        'Accept': "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      return {"content-type": "application/json", 'Accept': "application/json"};
    }
  }

  static Future<ResponseModel> postApiCAll(
      {required String url, Map<String, dynamic>? body}) async {
    http.Response response = await http.post(Uri.parse(url),
        headers: getHeaders(), body: jsonEncode(body) ?? jsonEncode({}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Enter in statuscode 200");
      return ResponseModel(
          data: response.body,
          headers: getHeaders(),
          error: "null",
          statusCode: response.statusCode.toString());
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      print("Enter in statuscode 400");
      print(
          "Enter in statuscode ${ResponseModel(statusCode: response.statusCode.toString(), error: response.statusCode.toString(), headers: getHeaders(), data: response.body).data}");

      return ResponseModel(
          statusCode: response.statusCode.toString(),
          error: response.statusCode.toString(),
          headers: getHeaders(),
          data: response.body);
    } else {
      print("Enter in $ResponseModel");
      return ResponseModel(
          statusCode: response.statusCode.toString(),
          error: response.statusCode.toString(),
          headers: getHeaders(),
          data: response.body);
    }
  }

  static Future<ResponseModel> getApiCall({required String url}) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ResponseModel(
          data: response.body,
          headers: getHeaders(),
          error: "null",
          statusCode: response.statusCode.toString());
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      return ResponseModel(
          statusCode: response.statusCode.toString(),
          error: response.statusCode.toString(),
          headers: getHeaders(),
          data: response.body);
    } else {
      return ResponseModel(
          statusCode: response.statusCode.toString(),
          error: response.statusCode.toString(),
          headers: getHeaders(),
          data: response.body);
    }
  }
}
