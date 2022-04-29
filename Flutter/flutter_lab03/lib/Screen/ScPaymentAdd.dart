import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_lab03/Model/Transaction.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'ScPayment.dart';

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

    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScPayment(),
                            ),
                          );
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
                  height: MediaQuery.of(context).size.height - 156,
                  width: double.infinity,
                  // color: Colors.white70,
                  child: Column(children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 45,
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
                          Tab(icon: Text('Cards', style: TextStyle(color: Colors.black),)),
                          Tab(icon: Text('Accounts', style: TextStyle(color: Colors.black),)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: <Widget>[
                                  // const Image(image: AssetImage('images/card.png'),),
                                  CreditCardWidget(
                                    cardType: CardType.visa,
                                    cardBgColor: Colors.teal,
                                    textStyle: const TextStyle(color: Colors.white),
                                    height: 200,
                                    cardNumber: cardNumber,
                                    expiryDate: expiryDate,
                                    cardHolderName: cardHolderName,
                                    cvvCode: cvvCode,
                                    showBackView: false,
                                    onCreditCardWidgetChange:(CreditCardBrand) {},
                                  ),
                                  CrediteCardForm(),
                                ],
                              )
                            ),
                          ),
                          // Text('cards'),
                          const Text('accounts')
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget CrediteCardForm () => Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CreditCardForm(
        formKey: formKey,
        obscureCvv: true,
        obscureNumber: true,
        cardNumber: cardNumber,
        cvvCode: cvvCode,
        isHolderNameVisible: true,
        isCardNumberVisible: true,
        isExpiryDateVisible: true,
        cardHolderName: cardHolderName,
        expiryDate: expiryDate,
        themeColor: Colors.teal,
        textColor: Colors.black,
        cardNumberDecoration: InputDecoration(
          labelText: 'Number',
          hintText: 'XXXX XXXX XXXX XXXX',
          hintStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: border,
          enabledBorder: border,
        ),
        expiryDateDecoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: border,
          enabledBorder: border,
          labelText: 'Expired Date',
          hintText: 'XX/XX',
        ),
        cvvCodeDecoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: border,
          enabledBorder: border,
          labelText: 'CVV',
          hintText: 'XXX',
        ),
        cardHolderDecoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: border,
          enabledBorder: border,
          labelText: 'Card Holder',
        ),
        onCreditCardModelChange: onCreditCardModelChange,
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Glassmorphism',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Switch(
                value: useGlassMorphism,
                inactiveTrackColor: Colors.grey,
                activeColor: Colors.teal,
                activeTrackColor: Colors.tealAccent,
                onChanged: (bool value) => setState(() {
                  useGlassMorphism = value;
                }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Card Image',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Switch(
                value: useBackgroundImage,
                inactiveTrackColor: Colors.grey,
                activeColor: Colors.teal,
                activeTrackColor: Colors.tealAccent,
                onChanged: (bool value) => setState(() {
                  useBackgroundImage = value;
                }),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          primary: Colors.tealAccent,
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: const Text(
            'Validate',
            style: TextStyle(
              // backgroundColor: Colors.white,
              color: Colors.white,
              fontFamily: 'halter',
              fontSize: 12,
              package: 'flutter_credit_card',
            ),
          ),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            debugPrint('valid!');
          } else {
            debugPrint('invalid!');
          }
        },
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
