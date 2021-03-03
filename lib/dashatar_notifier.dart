import 'package:dashatar_clone/models.dart';
import 'package:flutter/material.dart';

class DashatarNotifier extends ChangeNotifier {
  List<Role> _initRoles = [
    Role('Designer', color: Colors.blue.shade400),
    Role('Developer', color: Colors.green.shade400),
    Role('Manager', color: Colors.amber),
  ];

  Color accentColor;

  List<Role> get roles => _initRoles;

  Color get color => accentColor;

  void updateRole(Role chosenRole) {
    _initRoles.forEach((_role) {
      if (_role.text == chosenRole.text) {
        _role.isSelected = true;
        accentColor = _role.color;
      } else {
        _role.isSelected = false;
      }
    });
    _isResetable = true;

    notifyListeners();
  }

  final attributes = [
    Attribute('Strength'),
    Attribute('Agility'),
    Attribute('Wisdom'),
    Attribute('Charisma'),
  ];
  int currentPoints = 8;

  void lowerAttribute(Attribute chosenAttribute) {
    // If current points is 8, that means the points have not been used.
    // Therefore, there is no need of lowering it.
    // The lowest attribute point must be 1.
    if (currentPoints == 8 || chosenAttribute.points == 1) return;
    attributes.forEach((_attribute) {
      // If attribute is chosen
      if (_attribute.text == chosenAttribute.text) {
        _attribute.points--;
      }
    });
    currentPoints++;
    _isResetable = true;
    notifyListeners();
  }

  void increaseAttribute(Attribute chosenAttribute) {
    // If current points is 0, that means all the points is used up.
    // Therefore, there is no need to increase it.
    // An attribute can have a maximum of 5 points
    if (currentPoints == 0 || chosenAttribute.points == 5) return;
    attributes.forEach((_attribute) {
      // If attribute is chosen
      if (_attribute.text == chosenAttribute.text) {
        _attribute.points++;
      }
    });
    currentPoints--;
    _isResetable = true;
    notifyListeners();
  }

  bool _isResetable = false;

  bool get isResetable => _isResetable;

  void reset() {
    _initRoles.forEach((_attribute) => _attribute.isSelected = false);
    attributes.forEach((_attribute) => _attribute.points = 1);
    accentColor = null;
    _isResetable = false;
    currentPoints = 8;
    notifyListeners();
  }
}
