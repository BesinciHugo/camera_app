import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new MaterialApp(
    title: "Welcome to my Camera App",
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    home: cameraApp(),
  )
  );
}

class cameraApp extends StatefulWidget {
  _cameraAppState createState() => _cameraAppState();
}

class _cameraAppState extends State<cameraApp>{

  File? imageFile;



  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = picture as File?;
    });
    Navigator.of(context).pop();
  }


  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = picture as File?;
    });
    Navigator.of(context).pop();
  }



  Future<void> _showChoiseDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Pick one!"),
        content: SingleChildScrollView(
          child: ListBody (
            children:<Widget> [
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  _openGallery(context);
                },
              ),
        GestureDetector(
          child: Text("Camera"),
          onTap: () {
            _openCamera(context);
          },
        )],
          ),
        ) ,
      );
    });
  }
  
  Widget _decideImageView() {
    if(imageFile == null){
      return Text("Image not selected");
    }else {
      return Image.file(
        imageFile!,
        width: 400,
        height: 400,
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main page"),
      ),

      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              ElevatedButton(
                  onPressed: () {
                    _showChoiseDialog(context);
                  },
                  child: Text("Pick a picture"))
            ],
          ),
        ),
      ),
    );
  }

}