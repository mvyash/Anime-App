import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future login(String userName, String password) async {
  final url = Uri.https("kitsu.io", "/api/oauth/token");
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: json.encode({
      "grant_type": 'password',
      "username": userName,
      "password": Uri.encodeQueryComponent(
        password,
      ), // RFC3986 URl encoded string
    }),
  );

  if (response.statusCode != 200) {
    throw ErrorDescription("Error Detected!");
  }

  final body = json.decode(response.body);
}
