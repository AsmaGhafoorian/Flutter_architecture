


import 'package:inject/inject.dart';
import '../../main.dart';
import 'bloc_module.dart';
import 'bloc_injector.inject.dart' as g;
@Injector(const[BlocModule])
abstract class BlocInjector{

  @provide
  App get app; // App get app;, this is the root widget of our project and we are declaring it here so as to provide a destination where the dependencies will be injected

  static final create = g.BlocInjector$Injector.create;

}