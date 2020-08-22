

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/utils/radio_button_choice.dart';
import 'package:flutter_test_app/src/utils/text_styles.dart';
import 'package:inject/inject.dart';

@provide
class Profile extends StatefulWidget{


  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile>{

  @override
  void initState() {
    super.initState();
    print("PROOOOFIIILLLLLEEEEE");
  }

  final _formKey = GlobalKey<FormState>();
  var currentSelectedValue;
  final _gender = ["male", "female"];
  bool _isSwitch = false;
  bool _isCheckboxSelected = false;
  Map<String, bool> _checkBoxValues = {
    "Writing" : true,
    "Cooking" : false,
    "Gardening": false,
    "Cycling": false,
    "Photography": false,
    "Cricket": false
  };

  String _defaultChoice = 'Standard(14 days)';
  int _defaultIndex = 0;
  List<RadioButtonChoice> _radioChaices = [
    RadioButtonChoice(index:0, choice: 'Standard(14 days)', cost: '10.00'),
    RadioButtonChoice(index:1, choice: 'Express(7 days)', cost: '20.00'),
    RadioButtonChoice(index:2, choice: 'Premium(3 days)', cost: '30.00'),

  ];

  @override
  Widget build(BuildContext context) {

    return(Material(
        type: MaterialType.transparency, // remove yellow text underline

      child: ListView(
        children: <Widget>[ Container(

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  Center(
                    child: Text(
                      'About You',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                          fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Text(
                          'Contatct Details',
                            style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ]
                    ),
                  ),
                  Padding(

                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextFormField(// for validation and allows to show error with fail validation
                        validator: (value){
                          if(value.isEmpty){
                            return 'Enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(//The border, labels, icons, and styles used to decorate a Material Design text field
                            contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          )
                        ),
                      ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: TextFormField(   // for validation and allows to show error with fail validation
                        validator: (value){
                          if(value.isEmpty){
                            return 'Enter your family';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            border: OutlineInputBorder(),
                            hintText: 'Family',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )
                        ),
                      ),
                  ),


                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                     child: TextField(

                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15),

                              border: OutlineInputBorder(),
                              hintText: 'Address',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize : 12
                              )
                          )
                      ),
                    ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 15),
                              border: OutlineInputBorder()),
                          child: DropdownButtonHideUnderline(

                            child: DropdownButton<String>(
                              hint: Text("Select One",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                              ),

                              value: currentSelectedValue,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  currentSelectedValue = newValue;
                                });
                                print(currentSelectedValue);
                              },
                              items: _gender.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Travelling for work?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                        ),

                        Switch(
                          value: _isSwitch,
                          activeColor: Colors.blue,
                          activeTrackColor: Colors.lightBlueAccent,
                          onChanged: (value){
                            setState(() {
                              _isSwitch = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),

                  const Divider(
                    color: Colors.grey,
                    height: 4,
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            'Delivery',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ]
                    ),
                  ),

                  Container(
                    height: 200,
                  child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    children: _radioChaices.map((data) {
                      return
                            RadioListTile(
                              activeColor: Colors.blue,

                              title: new Text(
                                  data.choice,
                                  style: (data.index == _defaultIndex)? ThemeText().TextTheme1() : ThemeText().TextTheme2()

                              ),
                              groupValue: _defaultIndex,
                              value: data.index,
                              onChanged: (value) {
                                print(value.toString());
                                setState(() {
                                  _defaultChoice = _radioChaices[value].choice;
                                  _defaultIndex = value;
                                });
                              },
                            );
                    }).toList()
                  ),
                  ),

                  const Divider(
                    color: Colors.grey,
                    height: 4,
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            'Delivery',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ]
                    ),
                  ),

                  Container(
                    height: 200,
                    child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: _radioChaices.map((data) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

                            child: Row(
                                children : [
                                  Radio(
                                    activeColor: Colors.blue,

                                    groupValue: _defaultIndex,
                                    value: data.index,
                                    onChanged: (value) {
                                      print(value.toString());
                                      setState(() {
                                        _defaultChoice = _radioChaices[value].choice;
                                        _defaultIndex = value;
                                      });
                                    },
                                  ),
                                  Text(data.choice, textAlign: TextAlign.left,),
                                  Expanded(
                                  child: Text(data.cost, textAlign: TextAlign.right,)
                                  )
                                ]
                            ),
                          );
                        }).toList()
                    ),
                  ),

                  const Divider(
                    color: Colors.grey,
                    height: 4,
                  ),


                  Container(
                    height: 200,
                    child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: _checkBoxValues.keys.map((String key) {
                          return new CheckboxListTile(
                            activeColor: Colors.blue,

                            title: new Text(key,
                                style: ThemeText().TextTheme1()
                            ),
                            value: _checkBoxValues[key],
                            onChanged: (bool value) {
                              setState(() {
                                _checkBoxValues[key] = value;
                              });
                            },
                          );
                        }).toList()
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: SizedBox(
                      width: double.infinity, // match parent
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          ),
                      color: Colors.red,
                      onPressed: (){

                        if(_formKey.currentState.validate()){
                          Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'با موفقیت ثبت شد'
                                ),
                              )
                          );
                        }
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ]
      )
    )
  );
  }
}