import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wallet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
            margin: const EdgeInsets.only(top: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            debugPrint('Clicked back!');
                          }),
                      const Text(
                        "Wallet",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      IconButton(
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            debugPrint('Clicked notification!');
                          })
                    ],
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height - 104,
                    width: double.infinity,
                    // color: Colors.white,
                    child: Column(children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Total Balance',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '\$2,456.00',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Card(
                              child: InkWell(
                                  splashColor: Colors.green.withAlpha(30),
                                  onTap: () {
                                    debugPrint('Add card tapped.');
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    height: 55,
                                    child: Column(children: const <Widget>[
                                      // Icon(
                                      //   Icons.add_rounded,
                                      //   color: Colors.green,
                                      //   size: 30,
                                      // ),
                                      Image(image: AssetImage('images/plus.png')),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Add'),
                                    ]),
                                  ))),
                          Card(
                              child: InkWell(
                                  splashColor: Colors.green.withAlpha(30),
                                  onTap: () {
                                    debugPrint('Pay card tapped.');
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    height: 55,
                                    child: Column(children: const <Widget>[
                                      Icon(
                                        Icons.payment_rounded,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Pay'),
                                    ]),
                                  ))),
                          Card(
                              child: InkWell(
                                  splashColor: Colors.green.withAlpha(30),
                                  onTap: () {
                                    debugPrint('Send card tapped.');
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    height: 55,
                                    child: Column(children: const <Widget>[
                                      Icon(Icons.send_rounded,
                                          color: Colors.green, size: 30),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Send'),
                                    ]),
                                  ))),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 45,
                        padding: const EdgeInsets.all(2.0),
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                        ),
                        child: TabBar(
                          controller: _tabController,
                          padding: const EdgeInsets.all(2.0),
                          indicator: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          tabs: const [
                            Tab(icon: Text('Transactions', style: TextStyle(color: Colors.black),)),
                            Tab(icon: Text('Incoming Bills', style: TextStyle(color: Colors.black),)),
                          ],
                        ),
                      ),

                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            Icon(Icons.directions_car),
                            Icon(Icons.directions_transit),
                          ],
                        ),
                      ),
                    ]),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    )),
              ],
            )));
  }
}
