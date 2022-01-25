import 'package:flutter/material.dart';
import 'package:learning_flutter/example_three.dart';
import 'package:learning_flutter/example_two.dart';
import 'package:learning_flutter/example_without_modelclass.dart';
import 'package:learning_flutter/home_screen.dart';
import 'package:learning_flutter/signup.dart';
import 'package:learning_flutter/upload_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        //home: const ExampleThree());
         // home: const HomeScreen());
         // home: const ExampleTwo());
        // home: const ExampleWithOUtModelClass());

        //home: const SignUpScreen());

        home: const UploadImages());
  }
}
