

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
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rxdart/rxdart.dart';

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

    ProgressDialog pr;
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    return(Material(
        type: MaterialType.transparency,

          child : ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    StreamBuilder(
                      stream:  widget.bloc.allMovies,
                      builder: (context, AsyncSnapshot<MovieModel> snapshot) {

                        if (snapshot.hasError) print(snapshot.error);

                        if(snapshot.hasData) {
//                          setState(() {
//                            _load = false;
//                          });
                          return moviesList(snapshot);
                        }
                        else return Container();
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
                      child: SizedBox(
                        width: 300,
                    height: 200,
                    child: StreamBuilder(
                        stream:  widget.chartBloc.chart,
                        builder: (context, AsyncSnapshot<ChartModel> snapshot) {

                          return snapshot.hasData
                              ? Chart( snapshot)
                              : Container();

                        }
                    ),
                      )
                    ),
                  ]
                ),
              ),
            ],
          )
        )
    );

  }

 Widget showProgressBar() => Center(
     child: CircularProgressIndicator(
       backgroundColor: Colors.red,
     ),
   );


  onSelect(data) {
    setState(() {
      widget.chartBloc.getChartData();

    });
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
    var seriesList = List<charts.Series<chartDataSeries, String>>();

    var series = snapshot.data.series;
    var scaleX = snapshot.data.scale;
    var colors = [Colors.blue, Colors.yellow];
      for (var index=0;index<= series.length-1; index++) {
        List<chartDataSeries>  data = List<chartDataSeries>();
        for(var i=0; i<= series[index].values.length-1; i++){

            data.add(new chartDataSeries(scaleX.values[i], series[index].values[i]));
            print(data.toString());
      }
        seriesList.add(charts.Series<chartDataSeries, String>(
            id: series[index].text,
            domainFn: (chartDataSeries sales, _) => sales.dayName,
            measureFn: (chartDataSeries sales, _) => sales.dayValue,
            data: data,
            seriesColor: charts.ColorUtil.fromDartColor(colors[index])
        ));
    }

    return new charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

}

class chartDataSeries{
  final String dayName;
  final int dayValue;

  chartDataSeries(this.dayName, this.dayValue);

}
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}