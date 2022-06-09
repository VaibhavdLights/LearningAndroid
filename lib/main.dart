import 'package:flutter/material.dart';
import 'package:myapp/view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'firebase_options.dart';
import 'package:myapp/view/register_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // if (user?.emailVerified ?? false) {
              // } else {
              //   return const VerifyEmailView();
              // }
              // return const Text("Done...");
              return const LoginView();
            default:
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Please Verify your E-mail :"),
        TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text("Send Email Verification"))
      ],
    );
  }
}
