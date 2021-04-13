import 'package:flutter/material.dart';
import 'package:hatchery/manager/agreement_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';

class AgreementPage extends StatelessWidget {
  static StringsInfo _stringsInfo = StringsInfo();
  static AgreementPageTextStyle _agreementPageTextStyle =
      AgreementPageTextStyle();
  @override
  Widget build(BuildContext context) {
    AgreementManager _agreementManager = AgreementManager();
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => _agreementManager,
        child: _agreementMainView(context, _agreementManager),
      ),
    );
  }

  Widget _agreementMainView(context, manager) {
    print('DEBUG=> _agreementMainView 重绘了。。。。。。。。。。');
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "images/welcome.png",
              ))),
      child: _agreementDialogView(context, manager),
    );
  }

  Widget _agreementDialogView(BuildContext context, AgreementManager manager) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(26.0, 20.0, 26.0, 24.0),
      title: Text(
        "服务条款和用户协议提示",
        style: _agreementPageTextStyle.agreementTitle,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              _stringsInfo.agreement_card_text,
              style: _agreementPageTextStyle.agreementText,
              textAlign: TextAlign.start,
            ),
            Container(height: 10.0.h),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => manager.gotoUserAgreementUrl(),
                    child: Text("《用户协议》",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                  ),
                  GestureDetector(
                    onTap: () => manager.gotoPrivacyAgreementUrl(),
                    child: Text("《隐私政策》",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                  ),
                ],
              ),
            ),
            Container(height: 20.0.h),
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45.0.h,
                  child: ElevatedButton(
                    child: Text(
                      "确 定",
                      style: _agreementPageTextStyle.confirmBtn,
                    ),
                    onPressed: () => manager.clickAgreeAgreementButton(context),
                  ),
                ),
                Container(height: 10.0.h),
                GestureDetector(
                  onTap: () {
                    manager.exitApp();
                  },
                  child: Text(
                    "不同意并退出App",
                    style: _agreementPageTextStyle.closeAppBtn,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
