import 'package:dashatar_clone/dashatar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleButtons extends StatelessWidget {
  const RoleButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roles = Provider.of<DashatarNotifier>(context).roles;
    return Wrap(
      children: [
        for (var role in roles) ...[
          OutlinedButton(
            child: Text(role.text),
            style: OutlinedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 18,
              ),
              primary: role.isSelected ? Colors.white : role.color,
              backgroundColor:
                  role.isSelected ? role.color : Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              shape: StadiumBorder(),
            ).copyWith(
              side: MaterialStateProperty.all(
                BorderSide(color: role.color, width: 2),
              ),
            ),
            onPressed: () {
              context.read<DashatarNotifier>().updateRole(role);
            },
          ),
          SizedBox(width: 15),
        ]
      ],
    );
  }
}
