import 'package:dashatar_clone/dashatar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsoleBar extends StatelessWidget {
  const ConsoleBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashatarNotifier = Provider.of<DashatarNotifier>(context);
    final isResetable = dashatarNotifier.isResetable;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          Text(
            'Create your Dashatar',
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Color(0xFF478BF7)),
          ),
          Spacer(),
          TextButton(
            onPressed: isResetable ? dashatarNotifier.reset : null,
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: 24),
              minimumSize: Size(105, 50),
            ),
            child: Text('Reset'),
          ),
          SizedBox(width: 15),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 24),
              minimumSize: Size(137, 60),
            ),
            label: Text('Run'),
            icon: Icon(Icons.play_arrow),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
