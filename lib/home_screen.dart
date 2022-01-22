import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:learning_flutter/Models/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModel> postList =[];

  Future<List<PostModel>> getPostApi()async
  {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200)
      {
        postList.clear();
        for(Map i in data)
          {
            postList.add(PostModel.fromJson(i));
          }
        return postList;
      }
    else
        {
          return postList;
        }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context ,snapshot) {
                if (!snapshot.hasData) {
                  return Text('  Loading');
                }
                else {
                  return ListView.builder(
                    itemCount: postList.length ,
                      itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Center(
                              child: Text('API - LEARNING SECTION FLUTTER  ' , style:
                              TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),

                            Text('\nUSER ID:'+ postList[index].userId.toString()),

                            Text('ID  :'+ postList[index].id.toString()),

                            SizedBox(height: 5,),

                            Text('TITILES : '+ postList[index].title.toString()),

                            SizedBox(height: 5,),

                            const Text('BODY :',
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                            Text(postList[index].body.toString())

                          ],
                        ),
                      ),
                    );
                  });
                }
              },
            ),
          )

        ],
      ),
    );
  }
}
