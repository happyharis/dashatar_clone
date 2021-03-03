import 'package:dashatar_clone/console_bar.dart';
import 'package:dashatar_clone/dashatar_notifier.dart';
import 'package:dashatar_clone/models.dart';
import 'package:dashatar_clone/pulsing_text.dart';
import 'package:dashatar_clone/role_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(DashatarApp());
}

class DashatarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashatarNotifier(),
      child: MaterialApp(
        title: 'Dashatar App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/background.jpg',
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                    'images/dashatar.png',
                    width: 580,
                  ),
                ),
                DashatarConsole(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DashatarConsole extends StatelessWidget {
  const DashatarConsole({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        height: 750,
        width: 1300,
        child: Container(
          height: 750,
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConsoleBar(),
              Expanded(child: ConsoleBody()),
            ],
          ),
        ),
      ),
    );
  }
}

class ConsoleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          LeftSection(),
          SizedBox(width: 10),
          RightSection(),
        ],
      ),
    );
  }
}

class RightSection extends StatelessWidget {
  const RightSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Image.asset(
                'images/silhouette.png',
                height: constraints.maxHeight * 0.8,
              ),
            );
          },
        ),
      ),
    );
  }
}

class LeftSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 3.5, color: Color(0xFF478bf7)),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PulsingText(),
                    SizedBox(height: 30),
                    RoleButtons(),
                    SizedBox(height: 30),
                    AttributeSection(),
                    SizedBox(height: 30),
                    PointsRemaining(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AttributeSection extends StatelessWidget {
  const AttributeSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final attributes = Provider.of<DashatarNotifier>(context).attributes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('2. Select Attributes', style: TextStyle(fontSize: 30)),
        SizedBox(height: 20),
        for (var attribute in attributes) ...[
          Row(
            children: [
              Expanded(child: Text(attribute.text), flex: 1),
              AttributeButton(attribute: attribute)
            ],
          ),
          SizedBox(height: 15),
        ]
      ],
    );
  }
}

class AttributeButton extends StatelessWidget {
  const AttributeButton({
    Key key,
    @required this.attribute,
  }) : super(key: key);

  final Attribute attribute;

  @override
  Widget build(BuildContext context) {
    final dashNotifier = Provider.of<DashatarNotifier>(context);
    final points = dashNotifier.currentPoints;
    final selectedColor =
        dashNotifier.accentColor ?? Theme.of(context).textTheme.subtitle1.color;
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(
                  Icons.remove,
                  size: 30,
                  // Initial points is 8.
                  // If user has not increased the points or
                  // the points is at 1
                  color: points == 8 || attribute.points == 1
                      ? Colors.grey
                      : selectedColor,
                ),
                onPressed: () {
                  context.read<DashatarNotifier>().lowerAttribute(attribute);
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                attribute.points.toString(),
                style: TextStyle(color: selectedColor, fontSize: 20),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  // If user has no more points to increase
                  // the points is at 5 (which is max for a single)
                  // attribute
                  color: points == 0 || attribute.points == 5
                      ? Colors.grey
                      : selectedColor,
                ),
                onPressed: () {
                  context.read<DashatarNotifier>().increaseAttribute(attribute);
                }),
          ],
        ),
      ),
    );
  }
}

class PointsRemaining extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dashNotifier = Provider.of<DashatarNotifier>(context);
    final points = dashNotifier.currentPoints.toString();
    final color = dashNotifier.accentColor;
    final textTheme = Theme.of(context).textTheme.headline5;
    return RichText(
      text: TextSpan(
        text: points,
        style: textTheme.copyWith(color: color),
        children: [
          TextSpan(text: ' Points Remaining', style: textTheme),
        ],
      ),
    );
  }
}
