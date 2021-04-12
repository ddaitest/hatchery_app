import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/common/widget/app_bar.dart';
import 'package:hatchery/manager/feedback_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FeedbackNewPage extends StatelessWidget {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarFactory.getCommon("新问题反馈"),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 10),
                Text("请输入您要反馈的问题"),
                SizedBox(height: 10),
                TextFormField(
                  autofocus: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: "标题",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8),
                    ),
                  ),
                  controller: titleController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入内容';
                    } else if (value.length > 100) {
                      return '内容太长，请小于100';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  autofocus: true,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "联系方式",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8),
                    ),
                  ),
                  controller: phoneController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入您的手机号';
                    } else if (value.length > 20) {
                      return '格式不正确';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  maxLines: 5,
                  minLines: 1,
                  maxLength: 200,
                  decoration: InputDecoration(
                    labelText: "内容",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8),
                    ),
                  ),
                  controller: contentController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入内容';
                    }
                    return null;
                  },
                ),
                //图片
                Row(children: [
                  OutlinedButton.icon(
                      onPressed: () => _showSheetMenu(context),
                      icon: Icon(Icons.image),
                      label: Text("上传图片")),
                  SizedBox(width: 20),
                  Text("(可选一张图片上传)")
                ]),
                Selector<FeedbackManager, String>(
                  builder: (context, String value, child) {
                    if (value.isEmpty) {
                      return Container();
                    } else {
                      return Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: value,
                                width: 200,
                                height: 200,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  onPressed: () =>
                                      App.manager<FeedbackManager>()
                                          .removeImage()),
                            ],
                          )
                        ],
                      );
                    }
                  },
                  selector: (BuildContext context, FeedbackManager manager) {
                    return manager.uploadUrl;
                  },
                  shouldRebuild: (pre, next) =>
                      ((pre != next) || (pre.length != next.length)),
                ),
                ElevatedButton(
                  onPressed: () => submit(context),
                  child: Text('提交'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }

  ///上传图片
  _uploadImage(String filePath) {
    App.manager<FeedbackManager>().uploadImage(filePath).then((value) =>
        ScaffoldMessenger.of(App.navState.currentContext!)
            .showSnackBar(SnackBar(content: Text(value ? '上传成功' : "上传失败"))));
  }

  ///提交
  submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      var title = titleController.text;
      var phone = phoneController.text;
      var content = contentController.text;
      App.manager<FeedbackManager>().submit(title, phone, content).then((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('发布成功')));
        Navigator.pop(context);
      });
    }
  }

  _showSheetMenu(BuildContext context) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('选择图片'),
        actions: <Widget>[
          CupertinoActionSheetAction(
              child: const Text('相册'),
              onPressed: () => Navigator.pop(context, 'Gallery')),
          CupertinoActionSheetAction(
              child: const Text('照相机'),
              onPressed: () => Navigator.pop(context, 'Camera')),
        ],
        cancelButton: CupertinoActionSheetAction(
            child: const Text('取消'),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, 'Cancel')),
      ),
    ).then((String? value) {
      if (value != null) {
        getImageBy(value);
      }
    });
  }

  Future getImageBy(String type) async {
    var s = ImageSource.camera;
    if (type == "Gallery") {
      s = ImageSource.gallery;
    }
    final pickedFile = await ImagePicker().getImage(source: s);
    if (pickedFile == null) {
      return null;
    }
    File _image = File(pickedFile.path);
    print("DDAI _image.lengthSync=${_image.lengthSync()}");
    if (_image.lengthSync() > 2080000) {
      compressionImage(_image.path).then((value) {
        _uploadImage(_image.path);
      });
    } else {
      _uploadImage(_image.path);
    }
  }
}
