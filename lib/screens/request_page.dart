import 'package:boba_me/screens/home_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  TextEditingController bobaPlaceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String dropDownValue = 'State';
  List<String> states = ['State', 'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE',
    'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME',
    'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
    'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD',
    'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'];

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
                      margin: EdgeInsets.only(top: 35),
                      child: const Text(
                          'Don\'t see your favorite boba place?'
                          + '\nRequest it below with the city'
                          + '\nand state to be added!',
                          style: TextStyle(
                              fontFamily: 'Varela Round',
                              fontSize: 20,
                              color: Color(0xff4b553a)
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),
                ),
                Expanded(
                  flex: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                          child: TextField(
                            cursorColor: Color(0xff7c5b56),
                            style: const TextStyle(
                                color: Color(0xff7c5b56)
                            ),
                            controller: bobaPlaceController,
                            obscureText: false,
                            decoration: const InputDecoration(
                                hintText: 'Enter a boba place',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff7c5b56),
                                        width: 2.0
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff7c5b56),
                                        width: 2.0
                                    )
                                ),
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Color(0xff7c5b56)
                                )
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                          child: TextField(
                            cursorColor: Color(0xff7c5b56),
                            style: const TextStyle(
                                color: Color(0xff7c5b56)
                            ),
                            controller: bobaPlaceController,
                            obscureText: false,
                            decoration: const InputDecoration(
                                hintText: 'City',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff7c5b56),
                                        width: 2.0
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff7c5b56),
                                        width: 2.0
                                    )
                                ),
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Color(0xff7c5b56)
                                )
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16, bottom: 30),
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            value: dropDownValue,
                            icon: const Icon(
                                Icons.arrow_downward,
                                color: Color(0xff7c5b56)),
                            style: const TextStyle(color: Color(0xff7c5b56)),
                            underline: Container(
                              height: 2,
                              color: const Color(0xff7c5b56),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValue = newValue!;
                              });
                            },
                            items: states.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontFamily: 'Varela Round',
                                    color: Color(0xff7c5b56),
                                  ),
                                ),
                              );
                            }).toList(),
                            scrollbarAlwaysShow: true,
                            dropdownMaxHeight: 400,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 125,
                          child: ElevatedButton(
                            child: Text(
                                'Request'
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff7c5b56),
                              textStyle: TextStyle(
                                fontFamily: 'Varela Round',
                                color: Colors.white,
                              )
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
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
      ),
      endDrawer: Drawer(
        child: Container(
          color: const Color(0xffb87368),
          child: ListView(
            padding: EdgeInsets.only(top: 49),
            children: [
              ListTile(
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}