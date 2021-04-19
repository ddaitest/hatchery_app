import 'package:flutter/material.dart';
import 'package:hatchery/common/utils.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/agreement_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';

class AgreementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AgreementManager _agreementManager = AgreementManager();
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: ChangeNotifierProvider(
            create: (context) => _agreementManager,
            child: _agreementMainView(context, _agreementManager),
          ),
        ));
  }

  Widget _agreementMainView(context, manager) {
    print('DEBUG=> _agreementMainView 重绘了。。。。。。。。。。');
    return Stack(
      children: [
        Container(
          width: Flavors.sizesInfo.screenWidth,
          height: Flavors.sizesInfo.screenHeight,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "images/splash.jpg",
                  ))),
        ),
        _agreementDialogView(context, manager)
      ],
    );
  }

  Widget _agreementDialogView(BuildContext context, AgreementManager manager) {
    return Center(
        child: Container(
      width: (Flavors.sizesInfo.screenWidth - 28.0.w).w,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "服务条款和用户协议提示",
            style: Flavors.textStyles.agreementTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0.h),
          Text(
            Flavors.stringsInfo.agreement_card_text,
            style: Flavors.textStyles.agreementText,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10.0.h),
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
          SizedBox(height: 10.0.h),
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
          SizedBox(height: 10.0.h),
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
    ));
  }

  Future<bool> _onWillPop() async {
    return false;
  }
}
