import 'package:boba_me/screens/home_page.dart';
import 'package:boba_me/screens/request_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class How_To_Page extends StatefulWidget {
  const How_To_Page({Key? key}) : super(key: key);

  @override
  State<How_To_Page> createState() => _How_To_PageState();
}

class _How_To_PageState extends State<How_To_Page> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Boba Me'),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
              children: [
                Expanded(
                  flex: 80,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      children: [
                        Text(
                          'How To:',
                          style: TextStyle(
                              fontFamily: 'Varela Round',
                              fontSize: 36,
                              color: Color(0xff4b553a)
                          ),
                        ),
                        Text(
                          '1. Select a boba place from the list',
                          style: TextStyle(
                              fontFamily: 'Varela Round',
                              fontSize: 20,
                              color: Color(0xff4b553a)
                          ),
                        ),
                        Text(
                          '2. Check the boxes ',
                          style: TextStyle(
                              fontFamily: 'Varela Round',
                              fontSize: 20,
                              color: Color(0xff4b553a)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 20,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/coffee-milk-tea.png',
                          ),
                          Image.asset(
                            'assets/images/honeydew-milk-tea.png',
                          ),
                          Image.asset(
                            'assets/images/strawberry-milk-tea.png',
                          ),
                        ],
                      ),
                    )
                )
              ]
          )
      ),
      endDrawer: Container(
        width: 250,
        child: Drawer(
          child: Container(
            color: const Color(0xffb87368),
            child: ListView(
              padding: EdgeInsets.only(top: 50),
              children: [
                ListTile(
                  trailing: Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                        fontFamily: 'Varela Round',
                        color: Colors.white,
                        fontSize: 25
                    ),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                ),
                ListTile(
                  trailing: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Request',
                    style: TextStyle(
                        fontFamily: 'Varela Round',
                        color: Colors.white,
                        fontSize: 25
                    ),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RequestPage()));
                  },
                ),
                ListTile(
                  trailing: Icon(
                    Icons.question_mark,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'How To',
                    style: TextStyle(
                        fontFamily: 'Varela Round',
                        color: Colors.white,
                        fontSize: 25
                    ),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}