import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_chat/consts/color.dart';
import 'package:h_chat/consts/text_style.dart';
import 'package:h_chat/services/auth/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_page.dart'; // Add Firestore import

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthService());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home Page",
          style: ourStyle(
            size: 18.0,
            color: Colors.white,
            fWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {
              controller.signOut();
            },
            icon: const Icon(
              Icons.logout,
              size: 40,
              color: whiteColor,
            ),
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading...."),
          );
        }

        final List<Widget> userList = snapshot.data!.docs
            .map<Widget>(
                (documentSnapshot) => _buildUserListItem(documentSnapshot))
            .toList();

        return ListView(
          children: userList,
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    // You can use 'data' to display user information in a ListTile or any other widget.
    // Example:
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 5.0,
            ),
            Card(
              elevation: 3.0,
              child: Container(
                  alignment: Alignment.centerLeft,
                  height: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5.0,
                      ),
                      const CircleAvatar(
                        backgroundColor: whiteColor,
                        child: Icon(
                          Icons.person,
                          color: bgDarkColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        data['email'],
                        style: ourStyle(color: bgDarkColor),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        email: data['email'],
                        receiverUserId: data['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
