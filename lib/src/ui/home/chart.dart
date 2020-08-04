

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

    return(Container(

      child : Column(
        children: <Widget>[
          Container(
            child: StreamBuilder(
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
          ),
        ],

    )
    )
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
                    child : Column(
                        children : [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                          Container(

                          child: Align(
                              alignment: Alignment.bottomCenter,
                               child: Text(
                                    snapshot.data.items[index].profileName,

                                    style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                ),
                               )
                          )
                        ]
                    )
                )
            );
          },
        )
    );


  }
}