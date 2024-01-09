import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {},
          child: Icon(
            Icons.add_box_rounded,
            color: Colors.white60,
            size: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Color.fromARGB(232, 235, 221, 221),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(232, 235, 221, 221),
          toolbarHeight: 60,
          leadingWidth: 150,
          leading: Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '다녀온 곳',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.black),
                ]),
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu, color: Colors.black)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notification_add_outlined,
                            color: Colors.black))
                  ],
                )),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      child: Image.asset(
                        'assets/daejeon.jpg',
                      ),
                    ),
                    Container(
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: 261,
                          height: 32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          child: Text(
                            '제목 : 둔산대공원 사진',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: 261,
                          height: 32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text('위치 : 대전광역시 서구 둔산대로',
                              style: TextStyle(fontSize: 15)),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 261,
                            height: 32,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Text('날짜 : 2023-05-01',
                                style: TextStyle(fontSize: 15))),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 261,
                            height: 32,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.favorite),
                                Icon(Icons.comment),
                                Icon(Icons.share)
                              ],
                            ))
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}
