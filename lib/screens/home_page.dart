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
  var choices = ["7 Leaves Cafe", "85°C Bakery Cafe",
                 "Ding Tea", "Gong Cha", "It's Boba Time",
                 "Krak Boba", "Kung Fu Tea",
                 "Omomo", "Sharetea", "Sunright Tea Studio",
                 "Tastea", "Ten Ren's Tea Time"];
  bool milkTeaCheck = false, fruitTeaCheck = false, teaCheck = false;
  bool slushCheck = false, coffeeCheck = false, toppingsCheck = false;
  // bool isProcessing = false;
  static const Color darkBrown = Color(0xff7c5b56);

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
      FirebaseDatabase.instance.ref("places/" +
          dropdownValue!).get()
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
            randomTopping = "with " + topping;

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
              fontSize: 30
            ),
          ),
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
                                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: darkBrown,
                                              width: 2
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: darkBrown,
                                              width: 2
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: darkBrown,
                                                width: 2
                                          ),
                                        ),
                                      ),
                                      hint: const Text(
                                        "Select one",
                                        style: TextStyle(
                                            fontFamily: "Varela Round",
                                            color: darkBrown,
                                            fontSize: 20
                                        )
                                      ),
                                      items: choices.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                fontFamily: "Varela Round",
                                                color: Color(0xffc37254),
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
                                        padding: EdgeInsets.only(top: 2)
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 360,
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(3),
                                          thumbColor: MaterialStateProperty.all<Color>(const Color(0xffd3a081)),
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffffede1),
                                          borderRadius: BorderRadius.circular(3)
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: darkBrown
                                        ),
                                        iconSize: 30
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        padding: const EdgeInsets.only(left: 20),
                                        selectedMenuItemBuilder: (ctx, child) {
                                          return Container(
                                            color: const Color(0xffeec9b7),
                                            child: child,
                                          );
                                        }
                                      ),
                                      selectedItemBuilder: (BuildContext context) {
                                        return choices.map<Widget>((String item) {
                                          return Text(
                                            item,
                                            style: const TextStyle(
                                              color: darkBrown,
                                              fontFamily: "Varela Round",
                                              fontSize: 20
                                            ),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 22, top: 5),
                                    child: Row(
                                      children: [
                                        Theme(
                                          data: ThemeData(unselectedWidgetColor: darkBrown),
                                          child: SizedBox(
                                            height: 31,
                                            width: 31,
                                            child: Checkbox(
                                              activeColor: darkBrown,
                                              checkColor: Colors.white,
                                              value: milkTeaCheck,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  milkTeaCheck = value!;
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(2)
                                              )
                                            ),
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
                                              color: darkBrown
                                            )
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 15),
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: darkBrown),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: darkBrown,
                                                checkColor: Colors.white,
                                                value: fruitTeaCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    fruitTeaCheck = value!;
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(2)
                                                )
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
                                          child: const Text(
                                            "Fruit Tea",
                                            style: TextStyle(
                                                color: darkBrown
                                            )
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 15),
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: darkBrown),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: darkBrown,
                                                checkColor: Colors.white,
                                                value: teaCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    teaCheck = value!;
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(2)
                                                )
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
                                          child: const Text(
                                            "Tea",
                                            style: TextStyle(
                                                color: darkBrown
                                            )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 22),
                                    child: Row(
                                      children: [
                                        Theme(
                                          data: ThemeData(unselectedWidgetColor: darkBrown),
                                          child: SizedBox(
                                            height: 31,
                                            width: 31,
                                            child: Checkbox(
                                              activeColor: darkBrown,
                                              checkColor: Colors.white,
                                              value: slushCheck,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  slushCheck = value!;
                                                });
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(2)
                                              )
                                            ),
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
                                                color: darkBrown
                                            )
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 13),
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: darkBrown),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: darkBrown,
                                                checkColor: Colors.white,
                                                value: coffeeCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    coffeeCheck = value!;
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(2)
                                                )
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
                                          child: const Text(
                                            "Coffee",
                                            style: TextStyle(
                                                color: darkBrown
                                            )
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 12),
                                          child: Theme(
                                            data: ThemeData(unselectedWidgetColor: darkBrown),
                                            child: SizedBox(
                                              height: 31,
                                              width: 31,
                                              child: Checkbox(
                                                activeColor: darkBrown,
                                                checkColor: Colors.white,
                                                value: toppingsCheck,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    toppingsCheck = value!;
                                                  });
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(2)
                                                )
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
                                          child: const Text(
                                              "Toppings",
                                              style: TextStyle(
                                                  color: darkBrown
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
                                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                                child: SizedBox(
                                  height: 42,
                                  child: FilledButton(
                                    child: const Text(
                                      "Go",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: darkBrown,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor: darkBrown,
                                      disabledForegroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      )
                                    ),
                                    // onPressed: isProcessing == false ? () {
                                    //   setState(() {
                                    //     isProcessing = true;
                                    //     getDrink();
                                    //   });
                                    //   Timer(Duration(milliseconds: 1900), () {
                                    //     setState(() {
                                    //       isProcessing = false;
                                    //     });
                                    //   });
                                    // } : null,
                                    onPressed: () {
                                      getDrinks();
                                    },
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
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                randomOrder,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff4b553a)
                                ),
                                textAlign: TextAlign.center
                            ),
                            Visibility(
                              visible: toppingsCheck || !(milkTeaCheck || fruitTeaCheck
                                  || teaCheck || slushCheck || coffeeCheck || toppingsCheck),
                              child: Text(
                                  randomTopping,
                                  style: const TextStyle(
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