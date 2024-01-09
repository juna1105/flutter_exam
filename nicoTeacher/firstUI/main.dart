import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/button.dart';

void main() {
  runApp(MyApp());
}

final textStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
final textStyle1 = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
final textStyle2 = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.bold,
);
final boldText = TextStyle(
  fontSize: 31,
  fontWeight: FontWeight.bold,
);
final cardText = TextStyle(
  color: Colors.black,
  fontSize: 26,
  fontWeight: FontWeight.bold,
);
final cardText1 = TextStyle(
  color: Colors.black,
  fontSize: 23,
);
final cardText2 = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.w300,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.menu_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Global Wallet',
                            style: textStyle,
                          ),
                          Text(
                            'welcome to NICO',
                            style: textStyle2,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total Balance',
                        style: textStyle1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: Text(
                        '\$5 194 382',
                        style: boldText,
                      ),
                    ),
                    SizedBox(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                              width: 150,
                              height: 50,
                              child: button(
                                text: 'Transfer',
                                bgColor: Color(0xFFF1B33B),
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                            width: 150,
                            height: 50,
                            child: button(
                              text: 'Request',
                              bgColor: Colors.blueGrey[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(children: [
                    Expanded(
                      flex: 8,
                      child: Text(
                        'Wallets',
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'View All',
                        style: textStyle2,
                      ),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 5),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[100],
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20))),
                          child: cash_many_what(
                              cash: 'Euro',
                              many: '6 428€',
                              what: 'EUR',
                              img: 'assets/image1.jpg'),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -20),
                        child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[200],
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20))),
                            child: cash_many_what(
                              cash: 'Dollar',
                              many: '55 622\$',
                              what: 'USD',
                              img: 'assets/image2.jpg',
                            )),
                      ),
                      Transform.translate(
                        offset: Offset(0, -40),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[300],
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20))),
                          child: cash_many_what(
                            cash: 'Rupee',
                            many: '28 981₹',
                            what: 'INR',
                            img: 'assets/image3.jpg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class cash_many_what extends StatelessWidget {
  final String cash;
  final String many;
  final String what;
  final String img;
  const cash_many_what({
    required this.cash,
    required this.many,
    required this.what,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.centerLeft,
            height: 80,
            child: Text(
              cash,
              style: cardText,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              children: [
                Container(
                  child: Text(
                    many,
                    style: cardText1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    what,
                    style: cardText2,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      Container(
        child: Image.asset(
          img,
          width: 163,
          fit: BoxFit.cover,
        ),
      ),
    ]);
  }
}

class button extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? bgColor;
  button(
      {required this.text,
      this.textColor = Colors.black,
      this.bgColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 21,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
      onPressed: () {},
    );
  }
}
