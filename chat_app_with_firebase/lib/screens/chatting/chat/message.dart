import 'package:chat_app_with_firebase/screens/chatting/chat/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatelessWidget {
  Message({super.key});
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // chat 컬렉션을 구독한다
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'time',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            return ChatBubbles(
              // 문서의 userID / text값을 아규먼트로 받는 chatBubble 위젯
              isMe: chatDocs[index]['userID'].toString() == user!.uid,
              message: chatDocs[index]['text'],
              userName: chatDocs[index]['userName'],
              userImage: chatDocs[index]['userImage'],
            );
          },
        );
      },
    );
  }
}
