import 'package:flutter/material.dart';
import 'package:final_exam_chat_app/screen/ScFriendChats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chats',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ScFriendChatsPage(title: 'Chats'),
      initialRoute: '/friend_chats',
      routes: {
        '/friend_chats': (context) => const ScFriendChatsPage(title: 'Chats'),
      },
    );
  }
}