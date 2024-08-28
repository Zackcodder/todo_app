import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  final String baseUrl = 'https://reqres.in';

  ///login function
  login(String email, String password) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: headers,
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.green,
            msg: 'Login Successful',
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white);
        return response.statusCode;
      } else {
        Fluttertoast.showToast(
          fontSize: 18,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red.withOpacity(0.7),
          msg: 'Login Failed',
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  ///signup function
  signUp(String email, String password) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.post(
        Uri.parse('$baseUrl/api/register'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            fontSize: 18,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.green.withOpacity(0.7),
            msg: 'SignUp Successful',
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white);
        return response.statusCode;
      } else {
        Fluttertoast.showToast(
          fontSize: 18,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red.withOpacity(0.7),
          msg: 'Signup Failed',
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
        return;
      }
    } catch (e) {
      print(e);
    }
  }
}
