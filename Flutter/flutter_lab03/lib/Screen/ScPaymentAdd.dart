import 'package:flutter/material.dart';
import 'package:flutter_lab03/Model/Transaction.dart';

class ScPaymentAdd extends StatelessWidget {
  const ScPaymentAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ScPaymentAddPage(title: 'Connect Wallet'),
    );
  }
}

class ScPaymentAddPage extends StatefulWidget {
  const ScPaymentAddPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ScPaymentAddPage> createState() => _ScPaymentAddPageState();
}

class _ScPaymentAddPageState extends State<ScPaymentAddPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Transaction> transactions = [
    Transaction("UpWork", "Today", 850.00, 1, 1),
    Transaction("Transfer", "Yesterday", 85.00, 2, 0),
    Transaction("Paypal", "Jan 30, 2022", 1406.00, 3, 1),
    Transaction("Youtube", "Jan 16, 2022", 11.99, 4, 0),
    Transaction("Electricity", "Mar 28, 2022", 0.00, 5, 1),
    Transaction("House Rent", "Mar 31, 2022", 0.00, 6, 1),
    Transaction("Spotify", "Feb 28, 2022", 0.00, 7, 1),
  ];
  late int _selectedIndex = 2;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                height: 76,
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
                          Navigator.pop(context);
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
                  height: MediaQuery.of(context).size.height - 180,
                  width: double.infinity,
                  // color: Colors.white70,
                  child: Column(children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      padding: const EdgeInsets.all(2.0),
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                          Tab(icon: Text('Cards', style: TextStyle(color: Colors.black),)),
                          Tab(icon: Text('Accounts', style: TextStyle(color: Colors.black),)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const <Widget>[
                          Image(image: AssetImage('images/card.png'),),
                          Text('cards'),
                          Text('accounts')
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
          )),
      // bottomNavigationBar: NavigationBar(
      //   height: 40,
      //   backgroundColor: Colors.white,
      //   onDestinationSelected: (int index) {
      //     _onItemTapped(index);
      //   },
      //   selectedIndex: _selectedIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       icon: Icon(Icons.home_outlined, color: Colors.grey, size: 35,),
      //       label: '',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.bar_chart_outlined, color: Colors.grey, size: 35,),
      //       label: '',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.payment_outlined, color: Colors.grey, size: 35,),
      //       label: '',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.account_circle_outlined, color: Colors.grey, size: 35,),
      //       label: '',
      //     ),
      //   ],
      // ),
    );
  }
}
