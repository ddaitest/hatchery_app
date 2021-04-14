import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:hatchery/api/entity.dart';

class UpgradeDialog extends StatelessWidget {
  final UpgradeInfo upgrade;
  final bool canDismissDialog;
  UpgradeDialog(this.upgrade, this.canDismissDialog);

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Center(child: Text('Checking...')),
    );
  }
}
