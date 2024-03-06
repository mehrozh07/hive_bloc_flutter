import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function(dynamic)? onChange;
  final bool value;
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle = '',
    this.onChange,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // tileColor: Colors.white,
      title: Row(
        children: [
          Text(title,
              style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          if (subtitle.isNotEmpty)
            Text(subtitle,
                style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChange,
      ),
    );
  }
}
