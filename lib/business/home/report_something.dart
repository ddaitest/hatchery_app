import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/manager/report_st_manager.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hatchery/common/tools.dart';

class ReportSomethingPage extends StatefulWidget {
  @override
  ReportSomethingState createState() => ReportSomethingState();
}

class ReportSomethingState extends State<ReportSomethingPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String inputValue;
  String inputPhoneNumberValue;
  String imageUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportStManager(),
      child: _ScaffoldView(),
    );
  }

  _ScaffoldView() {
    return Consumer<ReportStManager>(
      builder: (context, manager, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "报事报修",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey[200],
        body: _bodyView(manager),
      ),
    );
  }

  Future getImageByGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('LC->image.lengthSync()###${image.lengthSync()}');
    if (image.lengthSync() > 2080000) {
      compressionImage(image.path).then((value) {
        print('LC->image.value###$value');
        ReportStManager().uploadReportStImage(value).then((info) {
          setState(() {
            imageUrl = info.toString();
            print('LC->###########$imageUrl');
          });
        });
      });
    } else {
      ReportStManager().uploadReportStImage(image.path).then((info) {
        setState(() {
          imageUrl = info.toString();
          print('LC->###########$imageUrl');
        });
      });
    }
  }

  Future getImageByCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image.lengthSync() > 2080000) {
      compressionImage(image.path).then((value) {
        ReportStManager().uploadReportStImage(value).then((info) {
          setState(() {
            imageUrl = info.toString();
            print('LC->###########$imageUrl');
          });
        });
      });
    } else {
      ReportStManager().uploadReportStImage(image.path).then((info) {
        setState(() {
          imageUrl = info.toString();
          print('LC->###########$imageUrl');
        });
      });
    }
  }

  void showActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        if (value == "Camera") {
          getImageByCamera();
        } else if (value == "Gallery") {
          getImageByGallery();
        }
      }
    });
  }

  _actionSheetMemu() {
    return showActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: const Text('选择图片'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('相册'),
            onPressed: () {
              Navigator.pop(context, 'Gallery');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('照相机'),
            onPressed: () {
              Navigator.pop(context, 'Camera');
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('取消'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        ),
      ),
    );
  }

  _bodyView(manager) {
    return Consumer<ReportStManager>(
        builder: (body, manager, bodychild) => Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    autofocus: true,
                    maxLines: 3,
                    maxLengthEnforced: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '请输入遇到的问题。',
                    ),
                    // ignore: missing_return
                    validator: (Value) {
                      if (Value.isEmpty) {
                        return '请输入内容';
                      } else {
                        inputValue = Value;
                      }
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: const Alignment(-0.95, 1.0),
                    child: imageUrl == null
                        ? GestureDetector(
                            onTap: () {
                              _actionSheetMemu();
                            },
                            child: Icon(
                              CommunityMaterialIcons.image_outline,
                              color: Colors.grey[400],
                              size: 50,
                            ))
                        : GestureDetector(
                            onTap: () {
                              _actionSheetMemu();
                            },
                            child: Container(
                              width: 150,
                              height: 200,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        " *  ",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      Text(
                        "联系电话",
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            hintText: '请输入联系电话。',
                          ),
                          // ignore: missing_return
                          validator: (phoneValue) {
                            RegExp reg = RegExp(r'^\d{11}$');
                            if (!reg.hasMatch(phoneValue)) {
                              return '请输入正确的手机号码';
                            }
                            if (phoneValue.isEmpty) {
                              return '请输入手机号码';
                            } else {
                              inputPhoneNumberValue = phoneValue;
                            }
                          },
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                          ],
                          onSaved: (value) {
                            value = inputPhoneNumberValue;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "提交",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        manager.postBody['message'] = inputValue;
                        manager.postBody['contact'] = inputPhoneNumberValue;
                        manager.postBody['img_url'] = imageUrl;
                        manager.postReportStData().then((info) {
                          if (info) {
                            manager.showToast("提交成功");
                            Navigator.pop(context);
                          } else {
                            manager.showToast("提交失败，请重试");
                          }
                        });
                      } else {
                        manager.showToast("请输入正确的信息");
                      }
                    },
                  ),
                )
              ]),
            )));
  }
}
