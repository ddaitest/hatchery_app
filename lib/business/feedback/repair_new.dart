import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/backgroundListenModel.dart';
import 'package:hatchery/common/log.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/common/widget/app_bar.dart';
import 'package:hatchery/common/widget/feedBackDetail_common.dart';
import 'package:hatchery/manager/feedback_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/routers.dart';

class RepairNewPage extends StatelessWidget {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File _imageFile = File('');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarFactory.getRoute("新的报事报修", "/repairs_list"),
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _titleMainView(),
                    _descMainView(),
                    _phoneMainView(),
                    _imageMainView(context),
                    SizedBox(height: 40.0.h),
                    _submitButtonView(context)
                  ],
                ),
              ),
            )));
  }

  Future<bool> _onWillPop() async {
    Routers.navigateReplace('/repairs_list');
    return true;
  }

  Widget _titleMainView() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '标题',
          style: Flavors.textStyles.feedBackDetailSort,
        ),
        _titleInputView()
      ],
    ));
  }

  Widget _titleInputView() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        autofocus: false,
        maxLines: 1,
        maxLength: 20,
        decoration: InputDecoration(
          labelText: "请输入标题",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.all(10.0),
        ),
        controller: titleController,
        // ignore: missing_return
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '请输入内容';
          } else if (value.length > 30) {
            return '内容太长，请小于30';
          }
          return null;
        },
      ),
    );
  }

  Widget _descMainView() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '详细内容',
          style: Flavors.textStyles.feedBackDetailSort,
        ),
        _descInputView()
      ],
    ));
  }

  Widget _descInputView() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        maxLines: 10,
        minLines: 1,
        maxLength: 200,
        decoration: InputDecoration(
          labelText: "请输入详细内容",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.all(10.0),
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
    );
  }

  Widget _phoneMainView() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '联系电话',
          style: Flavors.textStyles.feedBackDetailSort,
        ),
        _phoneInputView()
      ],
    ));
  }

  Widget _phoneInputView() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: "请输入联系方式",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.all(10.0),
        ),
        controller: phoneController,
        // ignore: missing_return
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '请输入您的手机号';
          } else if (value.length > 20) {
            return '手机格式不正确';
          }
          return null;
        },
      ),
    );
  }

  Widget _imageMainView(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '上传照片',
              style: Flavors.textStyles.feedBackDetailSort,
            ),
            _imageInputView(context)
          ],
        ));
  }

  Widget _imageInputView(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            //图片
            Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  child: _imageUploadProgress(context)),
              SizedBox(width: 20),
              Text("可选一张图片上传")
            ]),
          ],
        ));
  }

  Widget _imageAddView(BuildContext context) {
    return Container(
        width: 64.0.w,
        height: 64.0.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: IconButton(
          onPressed: () => _showSheetMenu(context),
          icon: Icon(
            Icons.add,
            size: 30.0,
            color: Color(0xFFD8D8D8),
          ),
        ));
  }

  Widget _imageUploadProgress(BuildContext context) {
    return Selector<RepairManager, double>(
      builder: (context, double value, child) {
        Log.log("progress=$value", color: LColor.YELLOW);
        if (value <= 0.0) {
          return _imageShowView(context);
        } else {
          return Container(
            width: 64.0.w,
            height: 64.0.h,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 32.0, bottom: 32.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                // value: value,
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
          );
        }
      },
      selector: (BuildContext context, RepairManager manager) {
        return manager.uploadProgress;
      },
    );
  }

  Widget _imageShowView(BuildContext context) {
    return Selector<RepairManager, String>(
      builder: (context, String value, child) {
        if (value.isEmpty || _imageFile.path == '') {
          return _imageAddView(context);
        } else {
          return Row(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                PhotoViewPage(imageFile: _imageFile))),
                    child: Image.file(_imageFile,
                        height: 64.0.h, width: 64.0.w, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 16.0.h,
                      width: 16.0.w,
                      decoration: BoxDecoration(
                        color: Color(0xFF000000),
                      ),
                      child: GestureDetector(
                        onTap: () => App.manager<RepairManager>().removeImage(),
                        child: Center(
                          child: Icon(
                            Icons.clear,
                            size: 15.0,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                  )
                ],
              )
            ],
          );
        }
      },
      selector: (BuildContext context, RepairManager manager) {
        return manager.uploadUrl;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }

  Widget _submitButtonView(BuildContext context) {
    return Container(
      height: 44.0.h,
      padding: const EdgeInsets.only(left: 64.0, right: 64.0),
      child: ElevatedButton(
        onPressed: () => submit(context),
        child: Text('提交反馈', style: Flavors.textStyles.submitButtonText),
      ),
    );
  }

  ///上传图片
  _uploadImage(String filePath) {
    App.manager<RepairManager>().uploadImage(filePath).then((value) =>
        ScaffoldMessenger.of(App.navState.currentContext!)
            .showSnackBar(SnackBar(content: Text(value ? '上传成功' : "上传失败"))));
  }

  ///提交
  submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      var title = titleController.text;
      var content = contentController.text;
      var phone = phoneController.text;
      App.manager<RepairManager>().submit(title, content, phone).then((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('发布成功')));
        // Navigator.pop(context, true);
        Routers.navigateReplace('/repairs_list');
      });
    }
  }

  _showSheetMenu(BuildContext context) {
    BackLock.working = true;
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
            onPressed: () => Navigator.pop(context)),
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
    Future.delayed(Duration(seconds: 1), () {
      BackLock.working = false;
    });
    if (pickedFile == null) {
      return null;
    }
    _imageFile = File(pickedFile.path);
    print("DDAI _image.lengthSync=${_imageFile.lengthSync()}");
    if (_imageFile.lengthSync() > 2080000) {
      compressionImage(_imageFile.path).then((value) {
        _uploadImage(_imageFile.path);
      });
    } else {
      _uploadImage(_imageFile.path);
    }
  }
}
