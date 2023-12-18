import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Text('Password reset link sent to! Check your email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Please enter your email and we will send a password reset link',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.deepPurple,
                ),
              ),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
                  }
                  return null;
                },
                controller: _emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurple[200])),
            onPressed: passwordReset,
            child: const Text(
              'Send link to email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
