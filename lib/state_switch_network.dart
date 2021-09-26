import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OnOffAnimation extends StatefulWidget {
  final bool switchOn;
  const OnOffAnimation({Key? key, this.switchOn = false}) : super(key: key);

  @override
  State<OnOffAnimation> createState() => _OnOffAnimationState();
}

class _OnOffAnimationState extends State<OnOffAnimation> {
  SMIBool? onoff;

  @override
  Widget build(BuildContext context) {
    onoff?.change(widget.switchOn);

    return SizedBox(
      width: 100,
      height: 100,
      child: RiveAnimation.network(
        'https://public.rive.app/community/runtime-files/450-872-onoff-switch.riv',
        stateMachines: const ["State Machine 1"],
        onInit: (Artboard artboard) {
          setState(() {
            final controller = StateMachineController.fromArtboard(
                artboard, 'State Machine 1');
            artboard.addController(controller!);
            onoff = controller.findInput<bool>('On/Of') as SMIBool;
          });
        },
      ),
    );
  }
}
