

import 'package:flutter/material.dart';

import 'src/di/bloc_injector.dart';
import 'src/di/bloc_module.dart';
import 'src/ui/home.dart';
import 'package:inject/inject.dart';

import 'src/ui/home.dart';

typedef Provider<T> = T Function();

void main() async{

  var container = await BlocInjector.create(BlocModule());
  runApp(container.app);
}

@provide
class App extends StatelessWidget {
  final Provider<Home> home;

  App( this.home) : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: home()),
    );
  }
}
