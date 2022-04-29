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
  String? dropDownValue;
  bool requested = false, validRequest = false;
  List<String> states = ['State', 'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE',
    'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME',
    'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
    'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD',
    'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Boba Me'),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              '\nDon\'t see your favorite boba place?'
                                  + '\nRequest it below with the city'
                                  + '\nand state to be added!',
                              style: TextStyle(
                                  fontFamily: 'Varela Round',
                                  fontSize: 22,
                                  color: Color(0xff4b553a)
                              ),
                              textAlign: TextAlign.center
                          ),
                        ]
                      ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            height: 86,
                            child: TextFormField(
                              cursorColor: Color(0xff7c5b56),
                              style: const TextStyle(
                                  color: Color(0xff7c5b56)
                              ),
                              controller: bobaPlaceController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                hintText: 'Enter a boba place',
                                  hintStyle: TextStyle(
                                      color: Color(0xff7c5b56)
                                  ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Color(0xff7c5b56),
                                        width: 2.0
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Color(0xff7c5b56),
                                        width: 2.0
                                    )
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        color: Color(0xff7c5b56),
                                        width: 2.0
                                    )
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(6),
                                ),

                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Required';
                                }
                              },
                              onChanged: (text) {
                                setState(() {

                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 65,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 16),
                                        height: 86,
                                        child: TextFormField(
                                          cursorColor: Color(0xff7c5b56),
                                          style: const TextStyle(
                                              color: Color(0xff7c5b56)
                                          ),
                                          controller: cityController,
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 20,
                                            ),
                                            hintText: 'City',
                                            hintStyle: TextStyle(
                                                color: Color(0xff7c5b56)
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    color: Color(0xff7c5b56),
                                                    width: 2.0
                                                )
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    color: Color(0xff7c5b56),
                                                    width: 2.0
                                                )
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(6),
                                                borderSide: BorderSide(
                                                    color: Color(0xff7c5b56),
                                                    width: 2.0
                                                )
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Required';
                                            }
                                          },
                                          onChanged: (text) {
                                            setState(() {

                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Expanded(
                                flex: 35,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20, right: 16),
                                        height: 86,
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButtonFormField2(
                                            dropdownMaxHeight: 390,
                                            dropdownOverButton: true,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff7c5b56),
                                                    width: 2),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff7c5b56),
                                                    width: 2),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(6),
                                                  borderSide: BorderSide(
                                                      color: Color(0xff7c5b56),
                                                      width: 2.0
                                                  )
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 2),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 2),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                            isExpanded: true,
                                            hint: const Text(
                                              'State',
                                              style: TextStyle(
                                                  color: Color(0xff7c5b56),
                                                  fontFamily: 'Varela Round',
                                                  fontSize: 16
                                              ),
                                            ),
                                            style: const TextStyle(
                                                color: Color(0xff7c5b56)
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Color(0xff7c5b56),
                                            ),
                                            iconSize: 30,
                                            scrollbarAlwaysShow: true,
                                            scrollbarRadius: Radius.circular(6),
                                            buttonHeight: 60,
                                            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            items: states.map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                        fontFamily: 'Varela Round',
                                                        color: Color(0xff7c5b56),
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == 'State' || value == null) {
                                                return '      Required';
                                              }
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                dropDownValue = value.toString();
                                              });
                                            },
                                            onSaved: (value) {
                                              setState(() {
                                                dropDownValue = value.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ]
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 55,
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                validRequest = true;
                                _formKey.currentState!.save();
                                FirebaseDatabase.instance.ref('requests').update({
                                  bobaPlaceController.text: {
                                    'city': cityController.text,
                                    'state': dropDownValue
                                  }
                                }).then((value) {
                                }).catchError((error) {
                                });
                                requested = true;
                              }
                              else {
                                validRequest = false;
                                requested = false;
                              }
                              setState(() {

                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                      child: Visibility(
                        visible: validRequest && requested,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                              'Thank you for your request!',
                              style: TextStyle(
                                  fontFamily: 'Varela Round',
                                  fontSize: 20,
                                  color: Color(0xff4b553a)
                              ),
                              textAlign: TextAlign.center
                          ),
                        ),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                      )
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
                              'assets/images/slushie.png',
                            ),
                            Image.asset(
                              'assets/images/coffee.png',
                            ),
                            Image.asset(
                              'assets/images/brown-sugar-milk-tea.png',
                            ),
                          ],
                        ),
                      )
                  )
                ]
            ),
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