// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "Email",
          ),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: "Password",
          ),
        ),
        TextButton(
          onPressed: () async {
            try {
              final email = _email.text;
              final password = _password.text;
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                // print("USER NOT FOUND");
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("USER NOT FOUND"),
                ));
              } else if (e.code == 'wrong-password') {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("WRONG PASSWORD"),
                ));
              }
            }
          },
          child: const Text("Login"),
        ),
      ],
    );
  }
}
