# stateswitch example

Quick example of using the https://public.rive.app/community/runtime-files/450-872-onoff-switch.riv file. 

# contents

- first example is using the .network. the state is controlled by clicking plus. 
    - to start this example in dark mode simply switch its condition `switchOn: _counter % 2 == 1`
- 2nd example is using the rootBundle
    - we are defaulting the state machine's `isDarkTheme`, which could start at true or false. You could replace this with a service that provides the current state value & calls to update it. 

# notes on the animation. 
The state machine here is called "State Machine 1".  
It has one "on/of" boolean state. 
When the state is true, the state machine transitions to dark mode. 

The state machine is setup with 3 states. 

Idle_on:
    cables are connected
    it sits here until the state is changed to true
Off: 
    cables animate to disconnected, and then stay disconnected
    it sits here until the state is changed to false
On: 
    cables animate to connect. 
    once the cables are connected, the state machine proceeds to "Idle_on"

Because of this setup, starting the state machine with the on/of set to true (which gets us to the Off animation of cables disconnected) will always start with an animation. we need to change the state machine to be able to start with idle on or idle off. 

Take a look at https://rive.app/community/850-1653-smiley-switch/ for examples of how to lay out the state machine for this. 