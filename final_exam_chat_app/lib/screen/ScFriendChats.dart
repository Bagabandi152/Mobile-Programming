import 'package:final_exam_chat_app/screen/ScPrivateChat.dart';
import 'package:flutter/material.dart';
import 'package:final_exam_chat_app/model/ChatUser.dart';

class ScFriendChat extends StatelessWidget {
  const ScFriendChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chats',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ScFriendChatsPage(title: "Chats"),
    );
  }
}

class ScFriendChatsPage extends StatefulWidget {
  const ScFriendChatsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ScFriendChatsPage> createState() => _ScFriendChatsPageState();
}

class _ScFriendChatsPageState extends State<ScFriendChatsPage> with TickerProviderStateMixin {
  late int _selectedIndex = 1;

  List<ChatUser> chatUsers = [
    ChatUser(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "images/img1.png", time: "Now"),
    ChatUser(name: "Gladys Murphy", messageText: "That's Great", imageURL: "images/img2.png", time: "Yesterday"),
    ChatUser(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "images/img3.png", time: "31 Mar"),
    ChatUser(name: "Philip Fox", messageText: "Busy! Call me in 20 minutes", imageURL: "images/img4.png", time: "28 Mar"),
    ChatUser(name: "Debra Hawkins", messageText: "Thank you, It's awesome", imageURL: "images/img5.png", time: "23 Mar"),
    ChatUser(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "images/img6.png", time: "17 Mar"),
  ];

  List<ChatUser> chatUsersFiltered = [
    ChatUser(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "images/img1.png", time: "Now"),
    ChatUser(name: "Gladys Murphy", messageText: "That's Great", imageURL: "images/img2.png", time: "Yesterday"),
    ChatUser(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "images/img3.png", time: "31 Mar"),
    ChatUser(name: "Philip Fox", messageText: "Busy! Call me in 20 minutes", imageURL: "images/img4.png", time: "28 Mar"),
    ChatUser(name: "Debra Hawkins", messageText: "Thank you, It's awesome", imageURL: "images/img5.png", time: "23 Mar"),
    ChatUser(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "images/img6.png", time: "17 Mar"),
  ];

  List<ChatUser> activeUsers = [
    ChatUser(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "images/img1.png", time: "Now"),
    ChatUser(name: "Gladys Murphy", messageText: "That's Great", imageURL: "images/img2.png", time: "Yesterday"),
    ChatUser(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "images/img3.png", time: "31 Mar"),
    ChatUser(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "images/img6.png", time: "17 Mar"),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void filterSearchResults(String query) {
    List<ChatUser> dummySearchList = [];
    dummySearchList.addAll(chatUsers);
    if(query.isNotEmpty) {
      List<ChatUser> dummyListData = [];
      for (var item in dummySearchList) {
        if(item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        chatUsersFiltered.clear();
        chatUsersFiltered.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        chatUsersFiltered.clear();
        chatUsersFiltered.addAll(chatUsers);
      });
    }
  }

  GestureDetector getUserAvatar(String imgUrl, int isActive){
    return
      GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ScPrivateChatPage(title: 'Private chat');
          }));
        },
        child: CircleAvatar(
          backgroundImage: AssetImage(imgUrl),
          // child: Image(image: AssetImage(imgUrl),),
          maxRadius: 30,
          backgroundColor: isActive == 1 ? Colors.teal : Colors.grey[100],
        ),
      );
  }

  GestureDetector getCharUserCard(String name, String messageText, String imgUrl, String time, int isMsgRead){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ScPrivateChatPage(title: 'Private chat');
        }));
      },
      child: Row(
        children: [
          Expanded(
            child:Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(imgUrl),
                  maxRadius: 30,
                  backgroundColor: isMsgRead == 1 ? Colors.teal : Colors.grey[100],
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(name, style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 6,),
                        Text(messageText, style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: isMsgRead == 0 ? FontWeight.bold:FontWeight.normal),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(time,style: TextStyle(fontSize: 12,fontWeight: isMsgRead == 0 ? FontWeight.bold : FontWeight.normal),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: const EdgeInsets.only(top: 24.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 76,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          debugPrint('Clicked back!');
                        }),
                    const Text(
                      "Chats",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.edit_note_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          debugPrint('Clicked edit note!');
                        })
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height - 156,
                  width: double.infinity,
                  // color: Colors.white70,
                  child: Column(children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: TextField(
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search, color: Colors.teal,),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.mic_sharp),
                                onPressed: () {
                                  /* Clear the search field */
                                },
                              ),
                              hintText: 'Search here...',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                            getUserAvatar('images/plus_icon.png', 0),
                            const SizedBox(width: 10,)
                            ],
                          ),
                          ListView.builder(
                            itemCount: activeUsers.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Row(
                                children: [
                                  getUserAvatar(activeUsers[index].imageURL, 1),
                                  const SizedBox(width: 10,)
                                ],
                              );
                            },
                          ),
                        ],
                      )
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListView.builder(
                                itemCount: chatUsersFiltered.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0),
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index){
                                  return Column(
                                    children: [
                                      getCharUserCard(chatUsersFiltered[index].name, chatUsersFiltered[index].messageText, chatUsersFiltered[index].imageURL, chatUsers[index].time,(index == 0 || index == 3)? 1 : 0,),
                                      const SizedBox(height: 10,)
                                    ],
                                  );
                                },
                              ),
                            ]
                      ))
                    )
                  ]),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                  )),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_enhance_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}