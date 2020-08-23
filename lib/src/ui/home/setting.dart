
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Setting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _SettingState();
  }


}

class _SettingState extends State<Setting>{
  final sizeDropdown = ['36','38','40'];
  var currentSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 70),
        child: ListTile(
            title: Text('Bar Modal'),
            onTap: () => (showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                ),
                context: context,
                builder: (builder){
                  return new Container(
                    height: 200,
                    color: Colors.transparent,

                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Size'
                          ),

                          DropdownButtonHideUnderline(

                            child: DropdownButton<String>(
                              hint: Text("36",
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
                              items: sizeDropdown.map((String value) {
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
                        ],
                      )
                    ],
                  )
                  );
                }
            )

            ),

        )
    );
  }

}