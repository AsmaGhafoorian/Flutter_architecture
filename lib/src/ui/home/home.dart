

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/bloc/MovieBloc.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';
import 'package:flutter_test_app/src/network/api_response.dart';

import 'package:inject/inject.dart';

import '../../bloc/MovieBloc.dart';


@provide
class Home extends StatefulWidget{
  final MoviesBloc bloc;

  Home(this.bloc);
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{

  @override
  void initState() {
    print("HOOOOOOOOOOOOOOOOOMMMMMMMM");
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

        child: StreamBuilder<ApiResponse<MovieModel>>(
            stream:  widget.bloc.allMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Container();
                      break;
                    case Status.COMPLETED:
                      return moviesList(snapshot.data.data);
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () => widget.bloc.fetchAllMovies(),
                      );
                }
              }
              return Container();
            }

    )
    )
    );
  }

  Widget moviesList(MovieModel snapshot) {
    return Container(
        height: 200,

        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.items.length,
          itemBuilder: (context, index) {

            return GestureDetector(

                child: Container(
                    width: 200,
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    child : Column(
                        children : [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children : [
                                Image.network(
                                  snapshot.items[index].iconUri,
                                  width: 50,
                                  height : 50,
                                ),
                                IconButton(
                                  icon: Icon(Icons.more),
                                )
                              ]
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

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}