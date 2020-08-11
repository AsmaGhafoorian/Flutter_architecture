

import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/bloc/MovieBloc.dart';
import 'package:flutter_test_app/src/bloc/chart_bloc.dart';
import 'package:flutter_test_app/src/bloc/movie_detail_bloc_provider.dart';
import 'package:flutter_test_app/src/model/chart_model.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:inject/inject.dart';

import '../../bloc/MovieBloc.dart';


class Chart extends StatefulWidget{
  final MoviesBloc bloc;
  final ChartBloc chartBloc;

  @provide
  Chart(this.bloc, this.chartBloc);

  @override
  _ChartState createState() => _ChartState();

}

class _ChartState extends State<Chart>{

  @override
  void initState() {
    super.initState();
    widget.bloc.fetchAllMovies();
    widget.chartBloc.getChartData();
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
    widget.chartBloc.dispose();
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
                    ),
                    Container(
                    child: StreamBuilder(
                        stream:  widget.chartBloc.chart,
                        builder: (context, AsyncSnapshot<ChartModel> snapshot) {

                          return snapshot.hasData
                              ? Chart(snapshot)
                              : Center(child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                          ));
                        }
                    ),
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

  Widget Chart(AsyncSnapshot<ChartModel> snapshot) {
    List<chartDataSeries>  data = List<chartDataSeries>();
    for(var i=0; i <=snapshot.data.scale.values.length-1 ; i++){

      for (var j = 0; j <= snapshot.data.series.length-1 ; j++) {
      data.add(new chartDataSeries(snapshot.data.scale.values[i], snapshot.data.series[j].values[i]));
      print(data.toString());
      }
    }

    var size = data.length / snapshot.data.series.length;
    var type1 = List<chartDataSeries>();
    type1.addAll(data.getRange(0, (size-1).toInt()));
    var type2 = List<chartDataSeries>();
    type2.addAll(data.getRange((size+1).toInt(), data.length-1));
    var seriesList = [
      new charts.Series<chartDataSeries, String>(
        id: 'Desktop',
        domainFn: (chartDataSeries sales, _) => sales.dayName,
        measureFn: (chartDataSeries sales, _) => sales.dayValue,
        data: type1,
      ),
      new charts.Series<chartDataSeries, String>(
        id: 'Tablet',
        domainFn: (chartDataSeries sales, _) => sales.dayName,
        measureFn: (chartDataSeries sales, _) => sales.dayValue,
        data: type2,
      )
    ];

    return new charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }
//    var chart = charts.<ChartModel>(
//      series,
//      animate: true,
//    );
//    var chartWidget = new Padding(
//      padding: new EdgeInsets.all(32.0),
//      child: new SizedBox(
//        height: 200.0,
//        child: chart,
//      ),
//    );


}

class chartDataSeries{
  final String dayName;
  final int dayValue;

  chartDataSeries(this.dayName, this.dayValue);

}