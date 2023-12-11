import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    loadModel();
    super.initState();
  }

  File? _selectedimage;
  var _confidence;
  var _label;

  loadModel() async {
    var result = await Tflite.loadModel(
        model: "assets/models/model.tflite",
        labels: "assets/models/labels.txt");
    print("model loaded: $result");
  }

  Future<dynamic> predict(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 15,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    if (res!.isEmpty) {
      setState(() {
        _confidence = null;
        _label = null;
      });
      print("reslt is empty ");
    } else {
      setState(() {
        _confidence = (res[0]['confidence'] * 100).round();
        _label = res[0]['label'];
      });
      print(res[0]);
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/wall5.webp"),
                fit: BoxFit.cover)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
                child: const Text(
                  "Iltimos Rasm tanlash tugmasini bosib rasm tanlang va o'simligingiz haqida to'liq ma'lumot oling ",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              _selectedimage != null
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(_selectedimage!)))
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Expanded(
                            child: Image(
                                image: AssetImage('assets/images/plant.jpg')),
                          ))),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  icon: const Icon(Icons.camera),
                  onPressed: () {
                    showImagePickerOption();
                  },
                  label: const Text(
                    "Rasm tanlash/olish",
                    style: TextStyle(color: Colors.black),
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: _confidence == null
                            ? const Text(
                                "Confidence: 0 %",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )
                            : Text(
                                "Confidence: $_confidence %",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )),
                    const SizedBox(
                      height: 8,
                    ),
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 50,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: _confidence == null ? 0.00 : _confidence / 100,
                      center: _confidence == null
                          ? const Text("0 %")
                          : Text("$_confidence %"),
                      barRadius: const Radius.circular(10),
                      progressColor: Colors.green,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: _label == null
                            ? const Text(
                                "Detection can't be working ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )
                            : Text(
                                "Disease: $_label",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )),
                  ],
                ),
              ),
            ]))));
  }

  void showImagePickerOption() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _imageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _imageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _imageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _selectedimage = File(returnImage.path);
      // _image = File(returnImage.path).readAsBytesSync();
    });

    predict(_selectedimage!);
    Navigator.of(context).pop();
  }

  Future _imageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      _selectedimage = File(returnImage.path);
      // _image = File(returnImage.path).readAsBytesSync();
    });
    predict(_selectedimage!);
    Navigator.of(context).pop();
  }
}
