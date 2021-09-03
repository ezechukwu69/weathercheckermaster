import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  const AuthButtons({
    Key? key,
    required this.title,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: icon == null ? 0 : 25,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon == null
                ? Container()
                : Container(
                    padding: EdgeInsets.only(
                      right: 8,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
