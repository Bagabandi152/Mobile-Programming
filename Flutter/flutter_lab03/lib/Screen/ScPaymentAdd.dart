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
      title: 'Connect Wallet',
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

  Card getAccountCard(String _status, String _imgUrl, String _title, String _desc){
    return Card(
      color: _status.isNotEmpty ? Colors.teal[100] : Colors.grey[100],
      child: Container(
        width: 350,
        height: 100,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(_imgUrl)),
            Column(
              children: [
                Text(_title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Text(_desc, style: const TextStyle(fontSize: 12,))
              ],
            ),
            _status.isNotEmpty ?  Image(image: AssetImage(_status)) : Row()
          ],
        ),
      ),
    );
  }

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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getAccountCard('images/right_shape.png', 'images/bank.png', 'Bank Link', 'Connect your bank account to deposit & fund'),
                              const SizedBox(height: 10),
                              getAccountCard('', 'images/dollar.png', 'Micro deposits', 'Connect bank in 5-7 days'),
                              const SizedBox(height: 10),
                              getAccountCard('', 'images/logo_paypal.png', 'Paypal', 'Connect your paypal account'),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 350,
                                height: 50,
                                child: ElevatedButton(
                                    child: const Text(
                                        "Next",
                                        style: TextStyle(fontSize: 15)
                                    ),
                                    style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                side: BorderSide(color: Colors.transparent),
                                            )
                                        )
                                    ),
                                    onPressed: () => {}
                                ),
                              )
                            ],
                          )
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
