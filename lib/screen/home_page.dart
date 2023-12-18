import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../readdata/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  //documents IDs
  List<String> docsId = [];

  //get docs IDs
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docsId.add(document.reference.id);
            }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page '),
      ),
      body: Center(
        child: Column(
          children: [
            Text('${user!.email}'),
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) => ListView.builder(
                  itemCount: docsId.length ,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GetUserName(documentId: docsId[index],),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: const Icon(Icons.exit_to_app_rounded),
      ),
    );
  }
}
