

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/bloc/MovieBloc.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';


class Home extends StatefulWidget{
  @override
  _Movie createState() => _Movie();

}

class _Movie extends State<Home>{
@override
  void initState() {
    bloc.fetchAllMovie();

  }

  @override
  void dispose() {
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return(MaterialApp(
     theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Asiatech'),
          centerTitle: true,
        ),
        body: StreamBuilder(

          stream: bloc.allMovie,
          builder: (context, AsyncSnapshot<MovieModel> snapshot) {
            if (snapshot.hasData) {
              Container(

                child: Column(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child :moviesList(snapshot)
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
        }
          )
      ),
   )
   );
  }

  Widget moviesList(AsyncSnapshot<MovieModel> snapshot) {
    return ListView.builder(

        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,

              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data
                    .results[index].poster_path}',
                fit: BoxFit.cover,
            ),
          );
        });
  }

}