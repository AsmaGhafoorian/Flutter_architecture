

import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/bloc/MovieBloc.dart';
import 'package:flutter_test_app/src/bloc/movie_detail_bloc_provider.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';

import 'package:inject/inject.dart';

import '../../bloc/MovieBloc.dart';


@provide
class Chart extends StatefulWidget{
  final MoviesBloc bloc;

   Chart(this.bloc);

  @override
  _ChartState createState() => _ChartState();

}

class _ChartState extends State<Chart>{

  @override
  void initState() {
    super.initState();
    widget.bloc.fetchAllMovies();

  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return(Material(
        type: MaterialType.transparency, // remove yellow text underline

        child: Container(

          child : Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    StreamBuilder(
                      stream:  widget.bloc.allMovies,
                      builder: (context, AsyncSnapshot<MovieModel> snapshot) {

                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                            ? moviesList( snapshot)
                            : Center(child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                        ));
                      }
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CalendarStrip(


                          iconColor: Colors.black87,
                          containerDecoration: BoxDecoration(color: Colors.white),
                          addSwipeGesture: true,
                          onDateSelected: onSelect,
                          monthNameWidget: _monthNameWidget,
                          dateTileBuilder: dateTileBuilder,
                        )
                    )
                  ]
                ),
              ),
            ],

          )
        )
      )
    );

  }
  onSelect(data) {
    print("Selected Date -> $data");
  }
  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.grey;
    TextStyle normalStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: fontColor);
    TextStyle selectedDayNameStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
    TextStyle selectedDayStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.red);

    List<Widget> _children = [
      Text(dayName, style: !isSelectedDate ? normalStyle : selectedDayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedDayStyle),
    ];

//    if (isDateMarked == true) {
//      _children.add(getMarkedIndicatorWidget());
//    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }
  Widget moviesList(AsyncSnapshot<MovieModel> snapshot) {
    return Container(
        height: 200,
        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.items.length,
          itemBuilder: (context, index) {

            return GestureDetector(

                child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
                    child : Column(
                        children : [
                    Expanded(

                    child : Align(
                            alignment: FractionalOffset.topCenter,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children : [
                                Image.network(
                                  snapshot.data.items[index].iconUri,
                                  width: 50,
                                ),
                                IconButton(
                                  icon: Icon(Icons.more),

                                )
                              ]
                          ),
                          ),
                    ),
                          Expanded(

                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                              child: Text(
                                    snapshot.data.items[index].profileName,

                                    style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                ),
                               )
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.max,// width = match_parent
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                              snapshot.data.items[index].point.toString(),

                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black
                              ),
                            ),
                            ]
                          ),

                        ]
                    )
                )
            );
          },
        )
    );


  }
}