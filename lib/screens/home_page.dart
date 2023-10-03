import 'package:boba_me/screens/how_to_page.dart';
import 'package:boba_me/screens/request_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dropDownValue = 'Select one', randomOrder = '', randomTopping = '', topping = '';
  var choices = ['Select one', '7 Leaves Cafe', '85°C Bakery Cafe',
                 'Ding Tea', 'Gong Cha', 'It\'s Boba Time',
                 'Krak Boba', 'Kung Fu Tea',
                 'Omomo', 'Sharetea', 'Sunright Tea Studio',
                 'Tastea', 'Ten Ren\'s Tea Time'];
  bool milkTeaCheck = false, fruitTeaCheck = false, teaCheck = false;
  bool slushCheck = false, coffeeCheck = false, toppingsCheck = false;
  bool isProcessing = false;

  List<String> getFromMap(Map map, String key, [String value = '']) {
    List<String> list = [];
    if (value != '') {
      if (map[key].containsKey(value)) {
        for (var val in map[key][value]) {
          list.add(val);
        }
      }
    }
    else {
      if (map.containsKey('toppings')) {
        for (var val in map[key]) {
          list.add(val);
        }
      }
    }
    return list;
  }

  void loadDrink() {
    var drinkList = [], toppingsList = [];
    final _random = Random();

    if (dropDownValue == 'Select one') {
      randomOrder = '';
      randomTopping = '';
    }
    else {
      randomOrder = '';
      randomTopping = '';
      topping = '';
      FirebaseDatabase.instance.ref('places/' +
          dropDownValue).get()
          .then((snapshot) {
            Map map = snapshot.value as Map;
            if (milkTeaCheck == false && fruitTeaCheck == false && teaCheck == false
                && slushCheck == false && coffeeCheck == false && toppingsCheck== false) {
              drinkList.addAll(getFromMap(map, 'drinks', 'milk tea'));
              drinkList.addAll(getFromMap(map, 'drinks', 'fruit tea'));
              drinkList.addAll(getFromMap(map, 'drinks', 'tea'));
              drinkList.addAll(getFromMap(map, 'drinks', 'slush'));
              drinkList.addAll(getFromMap(map, 'drinks', 'coffee'));
              toppingsList.addAll(getFromMap(map, 'toppings'));
              randomOrder = drinkList[_random.nextInt(drinkList.length)];
              topping = toppingsList[_random.nextInt(toppingsList.length)];
              while (randomOrder.contains(topping)) {
                topping = toppingsList[_random.nextInt(toppingsList.length)];
              }
              randomTopping = 'with ' + topping;
            }

            else {
              if (milkTeaCheck) {
                drinkList.addAll(getFromMap(map, 'drinks', 'milk tea'));
              }
              if (fruitTeaCheck) {
                drinkList.addAll(getFromMap(map, 'drinks', 'fruit tea'));
              }
              if (teaCheck) {
                drinkList.addAll(getFromMap(map, 'drinks', 'tea'));
              }
              if (slushCheck) {
                drinkList.addAll(getFromMap(map, 'drinks', 'slush'));
              }
              if (coffeeCheck) {
                drinkList.addAll(getFromMap(map, 'drinks', 'coffee'));
              }
              randomOrder = drinkList[_random.nextInt(drinkList.length)];

              if (toppingsCheck) {
                toppingsList.addAll(getFromMap(map, 'toppings'));
                topping = toppingsList[_random.nextInt(toppingsList.length)];
                while (randomOrder.contains(topping)) {
                  topping = toppingsList[_random.nextInt(toppingsList.length)];
                }
                randomTopping = 'with ' + topping;
              }
            }

            setState(() {});
      }).catchError((error) {});
    }

    // setState(() {});
  }

  void getDrink() {
    const milli = Duration(milliseconds: 170);
    var count = 1;
    Timer.periodic(milli, (Timer timer) {
      loadDrink();
      count++;
      if (count > 10) {
        timer.cancel();
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Boba Me'),
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 20,
                    child: Container(
                      // margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20, right: 5),
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropDownValue,
                                        icon: Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xff7c5b56)
                                        ),
                                        iconSize: 36,
                                        // elevation: 17,
                                        style: TextStyle(color: Color(0xff7c5b56)),
                                        underline: Container(
                                          height: 2,
                                          color: Color(0xff7c5b56),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropDownValue = newValue!;
                                          });
                                        },
                                        items: choices.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontFamily: 'Varela Round',
                                                  color: const Color(0xff7c5b56),
                                                  fontSize: 21
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        menuMaxHeight: 430,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Theme(
                                          data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                          child: SizedBox(
                                            height: 31,
                                            width: 31,
                                            child: Checkbox(
                                              activeColor: Color(0xff7c5b56),
                                              checkColor: Colors.white,
                                              value: milkTeaCheck,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  milkTeaCheck = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              milkTeaCheck = milkTeaCheck ? false : true;
                                            });
                                          },
                                          child: Text(
                                            'Milk Tea',
                                          style: TextStyle(
                                              color: const Color(0xff7c5b56)
                                          )
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: Color(0xff7c5b56),
                                                checkColor: Colors.white,
                                                value: fruitTeaCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    fruitTeaCheck = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              fruitTeaCheck = fruitTeaCheck ? false : true;
                                            });
                                          },
                                          child: Text(
                                              'Fruit Tea',
                                              style: TextStyle(
                                                  color: const Color(0xff7c5b56)
                                              )
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: Color(0xff7c5b56),
                                                checkColor: Colors.white,
                                                value: teaCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    teaCheck = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              teaCheck = teaCheck ? false : true;
                                            });
                                          },
                                          child: Text(
                                              'Tea',
                                              style: TextStyle(
                                                  color: const Color(0xff7c5b56)
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        Theme(
                                          data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                          child: SizedBox(
                                            height: 31,
                                            width: 31,
                                            child: Checkbox(
                                              activeColor: Color(0xff7c5b56),
                                              checkColor: Colors.white,
                                              value: slushCheck,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  slushCheck = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              slushCheck = slushCheck ? false : true;
                                            });
                                          },
                                          child: Text(
                                              'Slush',
                                              style: TextStyle(
                                                  color: const Color(0xff7c5b56)
                                              )
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 13),
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: Color(0xff7c5b56),
                                                checkColor: Colors.white,
                                                value: coffeeCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    coffeeCheck = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              coffeeCheck = coffeeCheck ? false : true;
                                            });
                                          },
                                          child: Text(
                                              'Coffee',
                                              style: TextStyle(
                                                  color: const Color(0xff7c5b56)
                                              )
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: Color(0xff7c5b56),
                                                checkColor: Colors.white,
                                                value: toppingsCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    toppingsCheck = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              toppingsCheck = toppingsCheck ? false : true;
                                            });
                                          },
                                          child: Text(
                                              'Toppings',
                                              style: TextStyle(
                                                  color: const Color(0xff7c5b56)
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                          Expanded(
                              flex: 25,
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 14),
                                child: SizedBox(
                                  height: 42,
                                  child: FilledButton(
                                    child: Text(
                                      'Go',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Color(0xff7c5b56),
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor: Color(0xff7c5b56),
                                      disabledForegroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      )
                                    ),
                                    onPressed: isProcessing == false ? () {
                                      setState(() {
                                        isProcessing = true;
                                        getDrink();
                                      });
                                      Timer(Duration(milliseconds: 1900), () {
                                        setState(() {
                                          isProcessing = false;
                                        });
                                      });
                                    } : null,
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            bottom: 15
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  randomOrder,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Color(0xff4b553a)
                                  ),
                                  textAlign: TextAlign.center
                              ),
                              // Text(
                              //     randomTopping,
                              //     style: TextStyle(
                              //         fontSize: 30,
                              //         color: Color(0xffdb6551)
                              //     ),
                              //     textAlign: TextAlign.center
                              // ),
                              Visibility(
                                visible: !(milkTeaCheck || fruitTeaCheck || teaCheck || slushCheck || coffeeCheck || toppingsCheck) || toppingsCheck,
                                child: Text(
                                    randomTopping,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xffdb6551)
                                    ),
                                    textAlign: TextAlign.center
                                ),
                                maintainSize: false,
                                maintainAnimation: true,
                                maintainState: true,
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 20,
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/jasmine-milk-tea.png',
                            ),
                            Image.asset(
                              'assets/images/matcha-milk-tea.png',
                            ),
                            Image.asset(
                              'assets/images/thai-tea.png',
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      flex: 20,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/taro-milk-tea.png',
                            ),
                            Image.asset(
                              'assets/images/milk-tea.png',
                            ),
                            Image.asset(
                              'assets/images/peach-milk-tea.png',
                            ),
                          ],
                        ),
                      )
                  )
                ]
            )
        ),
      // endDrawer: Container(
      //   width: 250,
      //   child: Drawer(
      //     child: Container(
      //       color: const Color(0xffb87368),
      //       child: ListView(
      //         padding: EdgeInsets.only(top: 50),
      //         children: [
      //           ListTile(
      //             trailing: Icon(
      //               Icons.home,
      //               size: 30,
      //               color: Colors.white,
      //             ),
      //             title: const Text(
      //               'Home',
      //               style: TextStyle(
      //                   fontFamily: 'Varela Round',
      //                   color: Colors.white,
      //                   fontSize: 25
      //               ),
      //               textAlign: TextAlign.right,
      //             ),
      //             onTap: () {
      //               Navigator.pop(context);
      //             },
      //           ),
      //           ListTile(
      //             trailing: Icon(
      //               Icons.add,
      //               size: 30,
      //               color: Colors.white,
      //             ),
      //             title: const Text(
      //               'Request',
      //               style: TextStyle(
      //                   fontFamily: 'Varela Round',
      //                   color: Colors.white,
      //                   fontSize: 25
      //               ),
      //               textAlign: TextAlign.right,
      //             ),
      //             onTap: () {
      //               Navigator.push(context, MaterialPageRoute(builder: (context) => RequestPage()));
      //             },
      //           ),
      //           // ListTile(
      //           //   trailing: Icon(
      //           //     Icons.question_mark,
      //           //     size: 30,
      //           //     color: Colors.white,
      //           //   ),
      //           //   title: const Text(
      //           //     'How To',
      //           //     style: TextStyle(
      //           //         fontFamily: 'Varela Round',
      //           //         color: Colors.white,
      //           //         fontSize: 25
      //           //     ),
      //           //     textAlign: TextAlign.right,
      //           //   ),
      //           //   onTap: () {
      //           //     Navigator.push(context, MaterialPageRoute(builder: (context) => How_To_Page()));
      //           //   },
      //           // ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}