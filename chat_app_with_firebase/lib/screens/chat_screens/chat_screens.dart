import 'package:chat_app_with_firebase/screens/chatting/chat/message.dart';
import 'package:chat_app_with_firebase/screens/chatting/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = authentication.currentUser;
    try {
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Chat Screen'),
        actions: [
          ElevatedButton(
            onPressed: () {
              authentication.signOut();
            },
            child: const Text('log out'),
          )
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Message(),
            ),
            const Expanded(
              flex: 2,
              child: NewMessage(),
            ),
          ],
        ),
      ),
    );
  }
}
