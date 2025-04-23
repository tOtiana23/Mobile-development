import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixth_lab/screen/photo_screen.dart';
import 'cubit/nasa_cubit.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => NasaCubit()..loadData(),
        child: PhotoScreen(),
      ),
    );
  }
}
