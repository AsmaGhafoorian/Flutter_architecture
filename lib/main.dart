

import 'package:flutter/material.dart';

import 'src/di/bloc_injector.dart';
import 'src/di/bloc_module.dart';
import 'src/ui/home/home_container.dart';
import 'package:inject/inject.dart';

import 'src/ui/home/home_container.dart';

typedef Provider<T> = T Function();

void main() async{

  var container = await BlocInjector.create(BlocModule());
  runApp(container.app);
}

@provide
class App extends StatelessWidget {
  final Provider<HomeContainer> home;

  App(this.home) : super();

  @override // ta zamani ke homebloc inject nashode method build dar home call nemishe va ta zamani ke myapp inject
              // nashode home inject nemishe. banabarin dar myapp niyaz be @provide darim
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      home: Scaffold(body: home()),
      routes: {
        '/home' : (context) => home()
      },
    );
  }
}
