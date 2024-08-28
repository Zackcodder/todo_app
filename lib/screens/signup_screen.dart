
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/authentication_provider.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 150, left: 16, right: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ///title
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Sign Up to continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              //email
              AppTextField(
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email',
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ///password
              AppTextField(
                hintText: 'Password*',
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.black,
                ),
                isPassword: true,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),

              ///login button
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  final email = emailController.text;
                  final password = passwordController.text;
                  authProvider.signIn(context, email, password);
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: authProvider.signUpLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ),
                    )
                  :const Center(child: Text('SignUp')),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}