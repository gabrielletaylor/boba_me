import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dropDownValue = 'Select one', randomOrder = '';

  void loadOrder() async {
    var url = Uri.parse('https://GenerateDrinks.gabbydavid.repl.co/' + dropDownValue);
    var response = await http.get(url);
    randomOrder = json.decode(response.body);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 20,
                    child: Container(
                        margin: EdgeInsets.only(left: 25, right: 5),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 75,
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
                                          color: const Color(0xff7c5b56)
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                            ),
                            Expanded(
                                flex: 25,
                                child: IconButton(
                                  icon: Image.network('https://www.clipartmax.com/png/full/100-1001613_50-lan-transparent-milk-tea-clipart.png'),
                                  iconSize: 70,
                                  onPressed: loadOrder,
                                )
                            ),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                      flex: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30,
                            right: 30),
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
                              'assets/images/jasmine-milk-tea.png',
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