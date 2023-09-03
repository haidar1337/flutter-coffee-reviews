import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speciality_coffee_review/models/authentication_handler.dart';
import 'package:speciality_coffee_review/screens/posts.dart';
import 'package:speciality_coffee_review/widgets/authentication_text_field.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() {
    return _AuthenticationScreenState();
  }
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = false;
  var _email = '';
  var _password = '';
  var _username = '';

  void switchMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void loginOrRegister() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();

    try {
      if (_isLogin) {
        AuthenticationHandler.login(_email, _password);
      } else {
        AuthenticationHandler.register(_email, _password, _username);
      }
    } on FirebaseAuthException catch (exception) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            exception.message ?? 'Something went wrong...',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
          ),
        ),
      );
    }

    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return const PostsScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.brown.withOpacity(0.2),
              Colors.brown,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color.fromARGB(255, 45, 43, 43), width: 4),
              color: const Color.fromARGB(255, 30, 28, 36),
            ),
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 20, right: 20, bottom: 30),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (!_isLogin)
                        AuthenticationTextField(
                          enableSuggestions: true,
                          fieldLabel: 'Username',
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 4) {
                              return 'Username must be at least 4 characters long';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _username = newValue!;
                          },
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthenticationTextField(
                        keyboardType: TextInputType.emailAddress,
                        fieldLabel: 'Email',
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 5 ||
                              !value.contains('@')) {
                            return 'Invalid Email address';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _email = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthenticationTextField(
                        obscuredText: true,
                        fieldLabel: 'Password',
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _password = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLogin
                                ? 'Don\'t have an account?'
                                : 'Already have an account?',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          TextButton(
                            onPressed: switchMode,
                            child: Text(
                              _isLogin ? 'Register' : 'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          onPressed: loginOrRegister,
                          child: Text(
                            _isLogin ? 'Login' : 'Register',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
