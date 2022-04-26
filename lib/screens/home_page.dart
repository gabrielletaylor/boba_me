import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dropDownValue = 'Select one', randomOrder = '';
  bool milkTeaCheck = false, fruitTeaCheck = false, slushCheck = false;
  bool toppingsCheck = false, coffeeCheck = false;

  void loadOrder() async {
    var drinkList = [], toppingsList = [];
    final _random = Random();
    randomOrder = '';

    if (dropDownValue == 'Select one') {
      randomOrder = '';
    }
    else {
      DatabaseReference drinksRef = FirebaseDatabase.instance.ref('places/' +
          dropDownValue + '/drinks');
      DatabaseReference toppingsRef = FirebaseDatabase.instance.ref('places/' +
          dropDownValue + '/toppings');
      DatabaseEvent event1 = await drinksRef.once();
      DatabaseEvent event2 = await toppingsRef.once();

      drinkList = event1.snapshot.value as List;
      toppingsList = event2.snapshot.value as List;

      randomOrder += drinkList[_random.nextInt(drinkList.length)];
      randomOrder += '\nwith ' + toppingsList[_random.nextInt(toppingsList.length)];
    }

    setState(() {});
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
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/jasmine-milk-tea.png',
                            ),
                            Image.asset(
                              'assets/images/thai-tea.png',
                            ),
                            Image.asset(
                              'assets/images/brown-sugar-milk-tea.png',
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                    flex: 20,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 25, right: 5),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: dropDownValue,
                                    icon: Icon(
                                        Icons.arrow_downward,
                                        color: Color(0xff7c5b56)),
                                    elevation: 16,
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
                                    items: <String>['Select one', '7 Leaves Cafe', 'Sharetea', 'Gong Cha']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontFamily: 'Varela Round',
                                              color: const Color(0xff7c5b56,),
                                              fontSize: 20
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 23),
                                  child: Row(
                                    children: [
                                      Theme(
                                        data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                        child: SizedBox(
                                          height: 35,
                                          width: 35,
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
                                      Text(
                                        'Milk Tea',
                                      style: TextStyle(
                                          color: const Color(0xff7c5b56)
                                      )
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Theme(
                                          data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                          child: SizedBox(
                                            height: 35,
                                            width: 35,
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
                                      Text(
                                          'Fruit Tea',
                                          style: TextStyle(
                                              color: const Color(0xff7c5b56)
                                          )
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Theme(
                                          data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                          child: SizedBox(
                                            height: 35,
                                            width: 35,
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
                                      ),
                                      Text(
                                          'Slush',
                                          style: TextStyle(
                                              color: const Color(0xff7c5b56)
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 23),
                                  child: Row(
                                    children: [
                                      Theme(
                                        data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                        child: SizedBox(
                                          height: 35,
                                          width: 35,
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
                                      Text(
                                          'Coffee',
                                          style: TextStyle(
                                              color: const Color(0xff7c5b56)
                                          )
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 21),
                                        child: Theme(
                                          data: ThemeData(unselectedWidgetColor: Color(0xff7c5b56)),
                                          child: SizedBox(
                                            height: 35,
                                            width: 35,
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
                                      Text(
                                          'Toppings',
                                          style: TextStyle(
                                              color: const Color(0xff7c5b56)
                                          )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                        Expanded(
                            flex: 25,
                            child: IconButton(
                              icon: Image.asset('assets/images/splash_logo.png'),
                              iconSize: 70,
                              onPressed: loadOrder,
                            )
                        ),
                      ],
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
                              'assets/images/honeydew-milk-tea.png',
                            ),
                            Image.asset(
                              'assets/images/milk-tea.png',
                            ),
                            Image.asset(
                              'assets/images/taro-milk-tea.png',
                            ),
                          ],
                        ),
                      )
                  )
                ]
            )
        )
    );
  }
}