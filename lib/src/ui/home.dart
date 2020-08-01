

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/bloc/MovieBloc.dart';
import 'package:flutter_test_app/src/bloc/movie_detail_bloc_provider.dart';
import 'package:flutter_test_app/src/model/movie_model.dart';


class Home extends StatefulWidget{
  @override
  _Movie createState() => _Movie();

}

class _Movie extends State<Home>{
@override
  void initState() {
    bloc.fetchAllMovies();

  }

  @override
  void dispose() {
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return(MaterialApp(
     theme: ThemeData(
     brightness: Brightness.light,
     primaryColor: Colors.white,
     accentColor: Colors.grey,
     ),
     color : Colors.grey,

     home: Scaffold(
        appBar: AppBar(
          title: Text('Asiatech'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: bloc.allMovies,
          builder: (context, AsyncSnapshot<MovieModel> snapshot) {

            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
              ? moviesList( snapshot)
                  : Center(child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            ));
              }
          )
      ),
   )
   );
  }

  Widget moviesList(AsyncSnapshot<MovieModel> snapshot) {
    return Container(
        height: 200,

        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.items.length,
          itemBuilder: (context, index) {

            return GestureDetector(
                onTap: () => openDetailPage(snapshot.data, index),

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
                        snapshot.data.items[index].iconUri,
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


  openDetailPage(MovieModel data, int index) {
    final page = MovieDetailBlocProvider(
//      child: MovieDetail(
//        title: data.results[index].title,
//        posterUrl: data.results[index].backdrop_path,
//        description: data.results[index].overview,
//        releaseDate: data.results[index].release_date,
//        voteAverage: data.results[index].vote_average.toString(),
//        movieId: data.results[index].id,
//      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }

}