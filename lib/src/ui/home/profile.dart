

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/bloc/MovieBloc.dart';
import 'package:flutter_test_app/src/bloc/movie_detail_bloc_provider.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';

import 'package:inject/inject.dart';

import '../../bloc/MovieBloc.dart';


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
  @override
  Widget build(BuildContext context) {


    return(Material(
        type: MaterialType.transparency, // remove yellow text underline

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children :<Widget>[
                      Text(
                        'About You',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                            fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),

                  Padding(

                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(// for validation and allows to show error with fail validation
                        validator: (value){
                          if(value.isEmpty){
                            return 'Enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          )
                        ),
                      ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(   // for validation and allows to show error with fail validation
                        validator: (value){
                          if(value.isEmpty){
                            return 'Enter your family';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            hintText: 'Family',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )
                        ),
                      ),
                  ),


                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                     child: TextField(

                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                              hintText: 'Address',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize : 12
                              )
                          )
                      ),
                    ),

                  Container(
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text("Select One"),
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

                  Row(
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


                  SizedBox(
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
                  )

                ],
              ),
            ),
    ),
    )
    );

  }
}