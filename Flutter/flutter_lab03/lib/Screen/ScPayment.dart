import 'package:flutter/material.dart';
import 'package:flutter_lab03/Model/Transaction.dart';
import 'package:flutter_lab03/Screen/ScPaymentAdd.dart';

class ScPayment extends StatelessWidget {
  const ScPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ScPaymentPage(title: 'Wallet'),
    );
  }
}

class ScPaymentPage extends StatefulWidget {
  const ScPaymentPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ScPaymentPage> createState() => _ScPaymentPageState();
}

class _ScPaymentPageState extends State<ScPaymentPage> with TickerProviderStateMixin {
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
                  height: MediaQuery.of(context).size.height - 155,
                  width: double.infinity,
                  // color: Colors.white70,
                  child: Column(children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Total Balance',
                      style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      '\$2,456.00',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                            elevation: 0,
                            child: InkWell(
                                splashColor: Colors.green.withAlpha(30),
                                onTap: () {
                                  debugPrint('Add card tapped.');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ScPaymentAdd(),
                                      // Pass the arguments as part of the RouteSettings. The
                                      // DetailScreen reads the arguments from these settings.
                                      // settings: RouteSettings(
                                      //   arguments: todos[index],
                                      // ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 100,
                                  height: 90,
                                  child: Column(children: <Widget>[
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.teal, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: const Image(image: AssetImage('images/plus.png')),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text('Add', style: TextStyle(fontSize: 14)),
                                  ]),
                                ))),
                        Card(
                            elevation: 0,
                            child: InkWell(
                                splashColor: Colors.green.withAlpha(30),
                                onTap: () {
                                  debugPrint('Pay card tapped.');
                                },
                                child: SizedBox(
                                  width: 100,
                                  height: 90,
                                  child: Column(children: <Widget>[
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.teal, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: const Image(image: AssetImage('images/qr_code.png')),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text('Pay', style: TextStyle(fontSize: 14)),
                                  ]),
                                ))),
                        Card(
                            elevation: 0,
                            child: InkWell(
                                splashColor: Colors.green.withAlpha(30),
                                onTap: () {
                                  debugPrint('Send card tapped.');
                                },
                                child: SizedBox(
                                  width: 100,
                                  height: 90,
                                  child: Column(children: <Widget>[
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.teal, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: const Image(image: AssetImage('images/send.png')),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text('Send', style: TextStyle(fontSize: 14)),
                                  ]),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45 ,
                      padding: const EdgeInsets.all(2.0),
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
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
                        children: [
                          ListView.builder(
                              itemCount: transactions.length - 3,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 0,
                                  key: UniqueKey(),
                                  margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 160,
                                          child:Row(
                                            children: [
                                              Image(image: AssetImage('images/' + transactions[index].img.toString() +  '.png')),
                                              const SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(transactions[index].name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                                                  Text(transactions[index].date, style: const TextStyle(fontSize: 13, color: Colors.grey),)
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                      Text(transactions[index].status == 1 ? '+\$' + transactions[index].mount.toString() : '-\$' + transactions[index].mount.toString(), style: TextStyle(
                                          color: transactions[index].status == 1 ? Colors.greenAccent : Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold
                                      ),)
                                    ],
                                  ),
                                );
                              }),
                          ListView.builder(
                              itemCount: transactions.length,
                              itemBuilder: (context, index) {
                                return index > 2 ? Card(
                                  elevation: 0,
                                  key: UniqueKey(),
                                  margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 160,
                                          child:Row(
                                            children: [
                                              Image(image: AssetImage('images/' + transactions[index].img.toString() +  '.png')),
                                              const SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(transactions[index].name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                                                  Text(transactions[index].date, style: const TextStyle(fontSize: 13, color: Colors.grey),)
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: const Text('Pay', style: TextStyle(color: Colors.teal),),
                                        style: OutlinedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: Colors.tealAccent,
                                          side: const BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ) : Container();
                              }),
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
      bottomNavigationBar: NavigationBar(
        height: 55,
        backgroundColor: Colors.white,
        onDestinationSelected: (int index) {
          _onItemTapped(index);
        },
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.grey, size: 30,),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined, color: Colors.grey, size: 30,),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.payment_outlined, color: Colors.grey, size: 30,),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined, color: Colors.grey, size: 30,),
            label: '',
          ),
        ],
      ),
    );
  }
}
