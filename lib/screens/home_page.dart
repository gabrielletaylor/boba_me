// import "package:boba_me/screens/how_to_page.dart";
// import "package:boba_me/screens/request_page.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:dropdown_button2/dropdown_button2.dart";
import "dart:math";
import "dart:async";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String randomOrder = "", randomTopping = "", topping = "";
  String? dropdownValue;
  var choices = ["7 Leaves Cafe", "85°C Bakery Cafe", "Cafe 86",
                 "Ding Tea", "Gong Cha", "It's Boba Time",
                 "Krak Boba", "Kung Fu Tea", "Omomo",
                 "Sharetea", "Sunright Tea Studio",
                 "Tastea", "Ten Ren's Tea Time"];
  bool milkTeaCheck = false, fruitTeaCheck = false, teaCheck = false;
  bool slushCheck = false, coffeeCheck = false, toppingsCheck = false;
  static const Color backgroundColor = Color(0xffffede1), headerColor = Color(0xffeec9b7);
  static const Color borderColor = Color(0xffd3a081), headerText = Color(0xffc37254);
  static const Color text3 = Color(0xff4b553a), text4 = Color(0xffdb6551);
  static const Color accent1 = Color(0xffe2b180), accent2 = Color(0xfff38373);
  static const Color accent3 = Color(0xffb87368), accent4 = Color(0xff7c5b56);
  static const Color accent5 = Color(0xffbd9a82);

  List<String> getFromMap(Map map, String key, [String value = ""]) {
    List<String> list = [];
    if (value != "") {
      if (map[key].containsKey(value)) {
        for (var val in map[key][value]) {
          list.add(val);
        }
      }
    }
    else {
      if (map.containsKey("toppings")) {
        for (var val in map[key]) {
          list.add(val);
        }
      }
    }
    return list;
  }

  void loadDrink() {
    var drinkList = [], toppingsList = [];
    final random = Random();

    if (dropdownValue != null) {
      randomOrder = "";
      randomTopping = "";
      topping = "";
      FirebaseDatabase.instance.ref("places/${dropdownValue!}").get()
          .then((snapshot) {
            Map map = snapshot.value as Map;
            if (!(milkTeaCheck || fruitTeaCheck || teaCheck || slushCheck || coffeeCheck || toppingsCheck)) {
              drinkList.addAll(getFromMap(map, "drinks", "milk tea"));
              drinkList.addAll(getFromMap(map, "drinks", "fruit tea"));
              drinkList.addAll(getFromMap(map, "drinks", "tea"));
              drinkList.addAll(getFromMap(map, "drinks", "slush"));
              drinkList.addAll(getFromMap(map, "drinks", "coffee"));
            }

            else {
              if (milkTeaCheck) {
                drinkList.addAll(getFromMap(map, "drinks", "milk tea"));
              }
              if (fruitTeaCheck) {
                drinkList.addAll(getFromMap(map, "drinks", "fruit tea"));
              }
              if (teaCheck) {
                drinkList.addAll(getFromMap(map, "drinks", "tea"));
              }
              if (slushCheck) {
                drinkList.addAll(getFromMap(map, "drinks", "slush"));
              }
              if (coffeeCheck) {
                drinkList.addAll(getFromMap(map, "drinks", "coffee"));
              }
            }

            randomOrder = drinkList[random.nextInt(drinkList.length)];
            toppingsList.addAll(getFromMap(map, "toppings"));
            do {
              topping = toppingsList[random.nextInt(toppingsList.length)];
            } while (randomOrder.contains(topping));
            randomTopping = "with $topping";

            setState(() {});
      }).catchError((error) {});
    }
  }

  void getDrinks() {
    var count = 1;
    Timer.periodic(const Duration(milliseconds: 160), (Timer timer) {
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
          title: const Text(
            "Boba Me",
            style: TextStyle(
              fontFamily: "Gaegu",
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: headerText
            ),
          ),
          backgroundColor: headerColor,
          shadowColor: borderColor,
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 20,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: DropdownButtonFormField2<String>(
                                      isExpanded: true,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: accent4,
                                            width: 2
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: accent4,
                                            width: 2
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: accent4,
                                            width: 2
                                          ),
                                        ),
                                      ),
                                      hint: const Text(
                                        "Select one",
                                        style: TextStyle(
                                          color: accent4,
                                          fontSize: 20
                                        )
                                      ),
                                      items: choices.map<DropdownMenuItem<String>>((String choice) {
                                        return DropdownMenuItem<String>(
                                          value: choice,
                                          child: Text(
                                            choice,
                                            style: const TextStyle(
                                              color: accent4,
                                              fontSize: 20,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      value: dropdownValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.only(top: 2),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 360,
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(3),
                                          thumbColor: MaterialStateProperty.all<Color>(accent4),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(3)
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: accent4
                                        ),
                                        iconSize: 30
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        padding: const EdgeInsets.only(left: 20),
                                        selectedMenuItemBuilder: (context, child) {
                                          return Container(
                                            color: accent5,
                                            child: child
                                          );
                                        }
                                      ),
                                      selectedItemBuilder: (BuildContext context) {
                                        return choices.map<Widget>((String choice) {
                                          return Text(
                                            choice,
                                            style: const TextStyle(
                                              color: accent4,
                                              fontSize: 20,
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 23, top: 5),
                                    child: Theme(
                                      data: ThemeData(unselectedWidgetColor: accent4),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 31,
                                            width: 31,
                                            child: Checkbox(
                                              activeColor: accent4,
                                              checkColor: Colors.white,
                                              value: milkTeaCheck,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  milkTeaCheck = value!;
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(3)
                                              )
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                milkTeaCheck = milkTeaCheck ? false : true;
                                              });
                                            },
                                            child: const Text(
                                              "Milk Tea",
                                              style: TextStyle(
                                                color: accent4
                                              )
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 15),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: accent4,
                                                checkColor: Colors.white,
                                                value: fruitTeaCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    fruitTeaCheck = value!;
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3)
                                                )
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                fruitTeaCheck = fruitTeaCheck ? false : true;
                                              });
                                            },
                                            child: const Text(
                                              "Fruit Tea",
                                              style: TextStyle(
                                                color: accent4
                                              )
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 15),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: accent4,
                                                checkColor: Colors.white,
                                                value: teaCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    teaCheck = value!;
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3)
                                                )
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                teaCheck = teaCheck ? false : true;
                                              });
                                            },
                                            child: const Text(
                                              "Tea",
                                              style: TextStyle(
                                                color: accent4
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 23),
                                    child: Theme(
                                      data: ThemeData(unselectedWidgetColor: accent4),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 31,
                                            width: 31,
                                            child: Checkbox(
                                              activeColor: accent4,
                                              checkColor: Colors.white,
                                              value: slushCheck,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  slushCheck = value!;
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(3)
                                              )
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                slushCheck = slushCheck ? false : true;
                                              });
                                            },
                                            child: const Text(
                                              "Slush",
                                              style: TextStyle(
                                                color: accent4
                                              )
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 13),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: accent4,
                                                checkColor: Colors.white,
                                                value: coffeeCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    coffeeCheck = value!;
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3)
                                                )
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                coffeeCheck = coffeeCheck ? false : true;
                                              });
                                            },
                                            child: const Text(
                                              "Coffee",
                                              style: TextStyle(
                                                color: accent4
                                              )
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 12),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: accent4,
                                                checkColor: Colors.white,
                                                value: toppingsCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    toppingsCheck = value!;
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(3)
                                                )
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                toppingsCheck = toppingsCheck ? false : true;
                                              });
                                            },
                                            child: const Text(
                                              "Toppings",
                                              style: TextStyle(
                                                color: accent4
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                          Expanded(
                              flex: 25,
                              child: Container(
                                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                                child: SizedBox(
                                  height: 42,
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: accent3,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      )
                                    ),
                                    onPressed: () {
                                      getDrinks();
                                    },
                                    child: const Text(
                                      "Go",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
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
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              randomOrder,
                              style: const TextStyle(
                                fontSize: 33,
                                color: text3,
                              ),
                              textAlign: TextAlign.center
                            ),
                            Visibility(
                              visible: toppingsCheck || !(milkTeaCheck || fruitTeaCheck
                                  || teaCheck || slushCheck || coffeeCheck || toppingsCheck),
                              maintainSize: false,
                              maintainAnimation: true,
                              maintainState: true,
                              child: Text(
                                  randomTopping,
                                  style: const TextStyle(
                                    fontSize: 33,
                                    color: text4,
                                  ),
                                  textAlign: TextAlign.center
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      flex: 20,
                      child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/jasmine-milk-tea.png",
                            ),
                            Image.asset(
                              "assets/images/matcha-milk-tea.png",
                            ),
                            Image.asset(
                              "assets/images/thai-tea.png",
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      flex: 20,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/taro-milk-tea.png",
                            ),
                            Image.asset(
                              "assets/images/milk-tea.png",
                            ),
                            Image.asset(
                              "assets/images/peach-milk-tea.png",
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
      //               "Home",
      //               style: TextStyle(
      //                   fontFamily: "Varela Round",
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
      //               "Request",
      //               style: TextStyle(
      //                   fontFamily: "Varela Round",
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
      //           //     "How To",
      //           //     style: TextStyle(
      //           //         fontFamily: "Varela Round",
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