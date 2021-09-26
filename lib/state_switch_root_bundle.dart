import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class StateSwitchRootBundle extends StatefulWidget {
  const StateSwitchRootBundle({Key? key}) : super(key: key);

  @override
  _StateSwitchRootBundleState createState() => _StateSwitchRootBundleState();
}

class _StateSwitchRootBundleState extends State<StateSwitchRootBundle> {
  bool isDarkTheme = false;
  Artboard? _riveArtboard;
  SMIInput<bool>? _setDarkTrigger;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/rive/450-872-onoff-switch.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        final controller = StateMachineController.fromArtboard(
          artboard,
          'State Machine 1',
          onStateChange: _onStateChange,
        )!;
        final setDarkTrigger = controller.findInput<bool>('On/Of')!;
        artboard.addController(controller);

        setDarkTrigger.change(isDarkTheme);

        setState(() {
          _riveArtboard = artboard;
          _setDarkTrigger = setDarkTrigger;
        });
      },
    );
  }

  // reacts to state machines state changes
  void _onStateChange(String stateMachineName, String stateName) {
    if (stateName == 'Off' && _setDarkTrigger?.value == true) {
      print('turn to dark side');
    } else if (stateName == 'Idle_on' && _setDarkTrigger?.value == false) {
      print('switch to light side');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : GestureDetector(
                onTapUp: (_) {
                  var setDarkTrigger = _setDarkTrigger;
                  if (setDarkTrigger != null) {
                    setDarkTrigger.change(!setDarkTrigger.value);
                  }
                },
                child: Rive(
                  artboard: _riveArtboard!,
                ),
              ),
      ),
    );
  }
}
