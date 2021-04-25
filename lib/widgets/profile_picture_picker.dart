import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicturePicker extends StatefulWidget {
  @override
  _ProfilePicturePickerState createState() => _ProfilePicturePickerState();
}

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
  File _image;
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: 65,
      backgroundImage: _image == null
          ? AssetImage(
              'assets/images/person.png',
            )
          : FileImage(_image),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: _image == null
              ? _imageButton(
                  onPressed: _onPictureSelectionDialog,
                  backgroundColor: Colors.white54,
                  icon: Icons.add)
              : _imageButton(
                  onPressed: _removePicture,
                  backgroundColor: Colors.red[700],
                  icon: Icons.close)),
    );
  }

  Container _imageButton(
      {Function onPressed, Color backgroundColor, IconData icon}) {
    return Container(
        height: 35,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: backgroundColor),
        child: IconButton(
            color: Colors.white,
            iconSize: 20,
            icon: Icon(icon),
            onPressed: onPressed));
  }

  _onPictureSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              //color: Colors.white,
              height: screenHeight / 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          minWidth: 100,
                          height: 100,
                          child: Text('Camera',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          //color: Color.fromRGBO(101, 255, 218, 50),
                          color: Theme.of(context).accentColor,
                          elevation: 10,
                          onPressed: () =>
                              {Navigator.pop(context), _chooseCamera()},
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        minWidth: 100,
                        height: 100,
                        child: Text('Gallery',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        color: Theme.of(context).accentColor,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseGallery()},
                      )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1920,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }

    _cropImage();
  }

  _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1920,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }

    _cropImage();
  }

  _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Theme.of(context).primaryColor,
            activeControlsWidgetColor: Theme.of(context).accentColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _removePicture() {
    _image = null;
    setState(() {});
  }
}
