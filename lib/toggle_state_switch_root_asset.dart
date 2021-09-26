import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class StateSwitchAsset extends StatefulWidget {
  const StateSwitchAsset({Key? key}) : super(key: key);

  @override
  _StateSwitchAssetState createState() => _StateSwitchAssetState();
}

class _StateSwitchAssetState extends State<StateSwitchAsset> {
  bool isDarkTheme = true;
  SMIInput<bool>? _setDarkTrigger;

  // reacts to state machines state changes
  void _onStateChange(String stateMachineName, String stateName) {
    if (stateName == 'Off' && _setDarkTrigger?.value == true) {
      print('turn to dark side');
      isDarkTheme = true;
    } else if (stateName == 'Idle_on' && _setDarkTrigger?.value == false) {
      print('switch to light side');
      isDarkTheme = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Center(
        child: GestureDetector(
          onTapUp: (_) {
            var setDarkTrigger = _setDarkTrigger;
            if (setDarkTrigger != null) {
              setDarkTrigger.change(!setDarkTrigger.value);
            }
          },
          child: RiveAnimation.asset(
            'assets/rive/450-872-onoff-switch.riv',
            stateMachines: const ["State Machine 1"],
            onInit: (Artboard artboard) {
              setState(() {
                final controller = StateMachineController.fromArtboard(
                    artboard, 'State Machine 1',
                    onStateChange: _onStateChange);
                artboard.addController(controller!);
                _setDarkTrigger =
                    controller.findInput<bool>('On/Of') as SMIBool;
                _setDarkTrigger!.change(isDarkTheme);
              });
            },
          ),
        ),
      ),
    );
  }
}
