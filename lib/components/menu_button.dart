import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
    @required this.title,
    @required this.image,
    @required this.press,
  }) : super(key: key);
  final String title, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: FlatButton(
          onPressed: press,
          child: Column(
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
                scale: 1.5,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                title ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          )),
    );
  }
}
