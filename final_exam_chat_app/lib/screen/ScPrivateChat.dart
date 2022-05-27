import 'package:flutter/material.dart';
import 'package:final_exam_chat_app/model/ChatMessage.dart';

class ScPrivateChat extends StatelessWidget {
  const ScPrivateChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User name',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ScPrivateChatPage(title: "User name"),
    );
  }
}

class ScPrivateChatPage extends StatefulWidget {
  const ScPrivateChatPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ScPrivateChatPage> createState() => _ScPrivateChatPageState();
}

class _ScPrivateChatPageState extends State<ScPrivateChatPage> with TickerProviderStateMixin {

  late String myMsg = "";

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  void initState() {
    super.initState();
  }

  void saveMsg(String val){
    setState(() {
      myMsg = val;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  const SizedBox(width: 2,),
                  const CircleAvatar(
                    backgroundImage: AssetImage("images/img1.png"),
                    maxRadius: 20,
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Kriss Benwat",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 6,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Active now",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                            const SizedBox(width: 5,),
                            const Icon(Icons.circle, color: Colors.teal, size: 10,)
                          ],
                        )
                      ],
                    ),
                  ),
                  const Icon(Icons.phone_outlined,color: Colors.black54,),
                  const SizedBox(width: 10,),
                  const Icon(Icons.video_call,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return Container(
                padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver" ? Alignment.topLeft : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType  == "receiver" ? Colors.grey.shade200 : Colors.teal[200]),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(messages[index].messageContent, style: const TextStyle(fontSize: 15),),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 300,
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 0, bottom: 0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: TextField(
                            // onChanged: (value) {
                            //   saveMsg(value);
                            // },
                            decoration: InputDecoration(
                                hintText: "Send Message",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        FloatingActionButton(
                          onPressed: (){},
                          child: const Icon(Icons.send_outlined, color: Colors.black45, size: 18,),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15,),
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.mic_sharp, color: Colors.white, size: 20, ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}