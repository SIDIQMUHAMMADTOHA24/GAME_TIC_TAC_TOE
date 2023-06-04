import 'package:api_list/app.dart';
import 'package:api_list/observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
