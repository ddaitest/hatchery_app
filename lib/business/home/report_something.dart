import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/manager/report_st_manager.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:image_picker/image_picker.dart';

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
      builder: (context) => ReportStManager(),
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
    print('LC->image.path###${image.path}');
    ReportStManager().uploadReportStImage(image.path).then((info) {
      setState(() {
        imageUrl = info.toString();
        print('LC->###########$imageUrl');
      });
    });
  }

  Future getImageByCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    print('LC->image.path###${image.path}');
    ReportStManager().uploadReportStImage(image.path).then((info) {
      setState(() {
        imageUrl = info.toString();
        print('LC->###########$imageUrl');
      });
    });
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 350, 5),
                      child: FlatButton(
                          onPressed: () {
                            showActionSheet(
                              context: context,
                              child: CupertinoActionSheet(
                                title: const Text('选择图片'),
                                //message: const Text('Please select the best mode from the options below.'),
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
                          },
                          child: imageUrl == null
                              ? Icon(
                                  CommunityMaterialIcons.image_outline,
                                  color: Colors.grey[400],
                                  size: 50,
                                )
                              : Image.network(imageUrl)),
                    )),
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
