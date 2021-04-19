import 'package:flutter/material.dart';
import 'package:hatchery/common/utils.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgreementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manager = App.manager<SplashManager>();
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: _agreementMainView(context, manager),
        ));
  }

  Widget _agreementMainView(context, manager) {
    print('DEBUG=> _agreementMainView 重绘了。。。。。。。。。。');
    return Container(
      width: Flavors.sizesInfo.screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "images/splash.jpg",
              ))),
      child: _agreementDialogView(context, manager),
    );
  }

  Widget _agreementDialogView(BuildContext context, manager) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "服务条款和用户协议提示",
              style: Flavors.textStyles.agreementTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0.h),
            Text(
              Flavors.stringsInfo.agreement_card_text,
              style: Flavors.textStyles.agreementText,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20.0.h),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => manager.gotoUserAgreementUrl(),
                    child: Text("用户协议",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                  ),
                  SizedBox(width: 20.0.w),
                  GestureDetector(
                    onTap: () => manager.gotoPrivacyAgreementUrl(),
                    child: Text("隐私政策",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0.h),
            Container(
              width: Flavors.sizesInfo.screenWidth,
              height: 45.0.h,
              child: ElevatedButton(
                child: Text(
                  "确 定",
                  style: Flavors.textStyles.agreementConfirmBtn,
                ),
                onPressed: () => manager.clickAgreeAgreementButton(context),
              ),
            ),
            SizedBox(height: 20.0.h),
            GestureDetector(
              onTap: () {
                showToast("需要同意才能继续使用");
              },
              child: Text(
                "不同意",
                style: Flavors.textStyles.agreementCloseAppBtn,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return false;
  }
}
