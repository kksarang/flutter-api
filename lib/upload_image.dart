import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:learning_flutter/upload_image.dart';
import 'package:image_picker/image_picker.dart';



class UploadImages extends StatefulWidget {
  const UploadImages({Key? key}) : super(key: key);

  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {

  File? image ;

  final _picker = ImagePicker();
  bool showSpinner = false;
  
  Future getImage() async{
    
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);

    if(pickedFile!=  null)
    {
      image=File(pickedFile.path);
      setState(() {

      });
    }
    else
      {
        print('no image selected');
      }
  }

  Future<void> uploadImage ()async{

    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());

    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('POST', uri);

    request.fields['title'] = "Static title";

    var multipart = new http.MultipartFile(
        'image',
        stream,
        length);

    request.files.add(multipart);

    var response = await request.send();

    if(response.statusCode== 200)
      {

        setState(() {
          showSpinner = false;
        });

        print('image uploaded');
      }
    else
      {
        print('failed');

        setState(() {
          showSpinner = false;
        });
      }

  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('UPLOAD IMAGE'),
        ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Container(
                  child: image == null ? Center(child: Text('Pick Image'),)
                      :
                  Container(
                    child: Center(
                      child: Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 200,),

              GestureDetector(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  height: 50,
                 width: 200,
                 color: Colors.green,
                 child: Center(child: Text('Upload',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                ),
              )

            ],
          )


      ),
    );
  }
}
