import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  // final double width;

  // const orDivider({
  //   // required this.width,
  // });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.015),
      width: size.width * 0.3,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              thickness: 1.2,
              color: Colors.white60.withOpacity(0.1),
            ),
          ),
          SizedBox(width: size.width * 0.01),
          Text(
            'auth.or'.tr(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 18, color: Colors.white70),
          ),
          SizedBox(width: size.width * 0.01),
          Expanded(
            child: Divider(
              thickness: 1.2,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
