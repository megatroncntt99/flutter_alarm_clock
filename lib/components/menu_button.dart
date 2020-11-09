import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/models/MenuInfo.dart';
import 'package:flutter_alarm_clock/theme_data.dart';
import 'package:provider/provider.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
    @required this.menuInfo,
  }) : super(key: key);
  final MenuInfo menuInfo;

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) {
        return FlatButton(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          onPressed: () {
            var menuInfo1 = Provider.of<MenuInfo>(context, listen: false);
            menuInfo1.updateMenuInfo(menuInfo);
          },
          color: menuInfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          child: Column(
            children: [
              Image.asset(
                menuInfo.image,
                fit: BoxFit.cover,
                scale: 1.5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                menuInfo.title ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
