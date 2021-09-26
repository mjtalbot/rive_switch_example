import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OnOffAnimationAsset extends StatefulWidget {
  final bool switchOn;
  const OnOffAnimationAsset({Key? key, this.switchOn = false})
      : super(key: key);

  @override
  State<OnOffAnimationAsset> createState() => _OnOffAnimationAssetState();
}

class _OnOffAnimationAssetState extends State<OnOffAnimationAsset> {
  SMIBool? onoff;

  @override
  Widget build(BuildContext context) {
    onoff?.change(widget.switchOn);

    return SizedBox(
      width: 100,
      height: 100,
      child: RiveAnimation.asset(
        'assets/rive/450-872-onoff-switch.riv',
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
