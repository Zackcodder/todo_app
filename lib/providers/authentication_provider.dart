// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/new_home.dart';
import 'package:todo_app/services/authentication_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();
  bool _signInLoading = false;
  bool get signInLoading => _signInLoading;
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  ///login function
  signIn(BuildContext context, String email, String password) async {
      _signInLoading = true;
    try {
      _signInLoading = true;
      final responseData = await _authService.login(email, password);

      if (responseData == 200) {
        _signInLoading = false;
        //navigate to home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewHomeScreen()),
        );
        notifyListeners();
      } else {
        _signInLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _signInLoading = false;
      notifyListeners();
    }
  }

  ///SignUp
  signUp(BuildContext context, String email, String password) async {
      _signUpLoading = true;
    try {
      _signUpLoading = true;
      final responseData = await _authService.signUp(email, password);
      if (responseData['message'] == 'success') {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );

        _signUpLoading = false;
        notifyListeners();
      } else {
        _signUpLoading = false;
        notifyListeners();
      }
      _signUpLoading = false;
      notifyListeners();
    } catch (e) {
      _signUpLoading = false;
      notifyListeners();
    }
  }
}
