

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/src/bloc/MovieBloc.dart';
import 'package:flutter_test_app/src/bloc/chart_bloc.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/ui/home/chart.dart';
import 'package:flutter_test_app/src/ui/home/home.dart';
import 'package:flutter_test_app/src/ui/home/profile.dart';
import 'package:flutter_test_app/src/ui/home/setting.dart';

import 'package:inject/inject.dart';

import '../../bloc/MovieBloc.dart';

typedef Provider<T> = T Function();

class HomeContainer extends StatefulWidget{
  final Provider<Home> home;
  final Provider<Chart> chart;

  @provide
  const HomeContainer( this.home, this.chart): super();

  @override
  _Movie createState() => _Movie();

}

class _Movie extends State<HomeContainer> with WidgetsBindingObserver{
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
  return(MaterialApp(

    theme: Theme.of(context),
     color : Colors.grey,

     home: Scaffold(
        appBar: AppBar(
          title: Text('Asiatech'),
          centerTitle: true,
        ),

       body: dynamicBody(),// or body: dynamicBody


       bottomNavigationBar: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
         items:[
           BottomNavigationBarItem(
             icon: Icon(Icons.insert_chart),
             title: Text(''),
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.home),
             title: Text(''),
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.person_outline),
             title: Text('School'),
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.build),
             title: Text('')
           ),
         ],
         currentIndex : _currentIndex,
         selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
         showSelectedLabels: false,
         showUnselectedLabels: false,

       ),
      ),
   )
   );
  }


  Widget dynamicBody() {

    return new Stack(
        children: <Widget>[
          new Offstage(
            offstage: _currentIndex != 0,
            child:  widget.chart(),
          ),
          new Offstage(
            offstage: _currentIndex != 1,
            child:  widget.home(),
          ),
          new Offstage(
            offstage: _currentIndex != 2,
            child:  Profile(),
          ),
          new Offstage(
            offstage: _currentIndex != 3,
            child:  Setting(),
          ),
        ]
    );
  }

  Widget bottomDynamicBody() {
    SafeArea( // or body: dynamicBody
      top: false,
      child: IndexedStack(
          index: _currentIndex,
          children: [widget.chart(), widget.home(), Profile(), Setting()]
      ),
    );
  }

  @override
  Future<bool> didPopRoute()  {

    return _currentIndex==0 ?showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Do you want to exit this application?'),
        content: new Text('We hate to see you leave...'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) :
    {
      setState(() {
        _currentIndex = 0;
      })
    };
  }

    void _onItemTapped(int index){
        setState(() {
          _currentIndex = index;
        });
    }
}