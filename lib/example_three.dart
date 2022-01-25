import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:learning_flutter/Models/user_model.dart';


class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  _ExampleThreeState createState() => _ExampleThreeState();
}


class _ExampleThreeState extends State<ExampleThree> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi()async
  {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200)
    {
      userList.clear();
      for(Map i in data)
      {
        print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else
    {
      return userList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title : Text('Api Example 3'),
      ),

      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getUserApi() ,
            builder: (context ,AsyncSnapshot<List<UserModel>> snapshot){

                     if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                    }
                     else
                        {
                       return ListView.builder(
                           itemCount: userList.length,
                           itemBuilder: (context, index){
                             return Card(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(

                                   children: [

                                     ReusbaleRow(title: 'ID :', value: snapshot.data![index].id.toString()),
                                     ReusbaleRow(title: 'NAME :', value: snapshot.data![index].name.toString()),
                                     ReusbaleRow(title: 'USERNAME :', value: snapshot.data![index].username.toString()),
                                     ReusbaleRow(title: 'EMAIL :', value: snapshot.data![index].email.toString()),
                                     ReusbaleRow(title: 'ADDRESS :', value: snapshot.data![index].address!.street.toString()),
                                     ReusbaleRow(title: '', value: snapshot.data![index].address!.suite.toString()),
                                     ReusbaleRow(title: '', value: snapshot.data![index].address!.city.toString()),
                                     ReusbaleRow(title: '', value: snapshot.data![index].address!.zipcode.toString()),
                                     ReusbaleRow(title: '', value: snapshot.data![index].address!.geo!.lat!.toString()),
                                     ReusbaleRow(title: '', value: snapshot.data![index].address!.geo!.lng!.toString()),



                                     // Row(
                                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     //   children: [
                                     //     Text('ID :'),
                                     //     Text(snapshot.data![index].id.toString()),
                                     //
                                     //   ],
                                     // ),
                                     // Row(
                                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     //   children: [
                                     //     Text('NAME :'),
                                     //          Text(snapshot.data![index].name.toString()),
                                     //   ],
                                     // ),



                                   ],
                                 ),
                               ),
                             );
                           });
                     }
            },
          ))


        ],
      ),

    );
  }
}


class ReusbaleRow extends StatelessWidget {
  String title ,value ;

   ReusbaleRow({Key? key , required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),

        ],
      ),
    );
  }
}
