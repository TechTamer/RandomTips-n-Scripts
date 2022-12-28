#!/bin/bash

##### Simple led functions for testing on Rasperry Pi

### Set up variables
#	Map gpio pins to colors
RED_LED=17
YELLOW_LED=22
GREEN_LED=10
BLUE_LED=9
ALL_LED="$RED_LED $YELLOW_LED $GREEN_LED $BLUE_LED"
#	Set command path
GPIO="/usr/bin/raspi-gpio"
SLEEP="/usr/bin/sleep"
#	Set Times
SLOW_DELAY=1
SLIGHT_DELAY=.25
DELAY=.5

### SET_GPIO : Set pins as output
function SET_GPIO {
	echo "Setting GPIO pins as output"
	$GPIO set $RED_LED op
	$GPIO set $YELLOW_LED op
	$GPIO set $GREEN_LED op
	$GPIO set $BLUE_LED op
}

### GET_GPIO : Get all the pin data
function GET_GPIO {
	echo "Getting all pin data"
	for LED in $ALL_LED
	do
		$GPIO get $LED
	done
}

#####	Turning on lights	#####
function RED_ON {
        $GPIO set $RED_LED dh
}
function YELLOW_ON {
        $GPIO set $YELLOW_LED dh
}
function GREEN_ON {
        $GPIO set $GREEN_LED dh
}
function BLUE_ON {
        $GPIO set $BLUE_LED dh
}
### ALL_ON : Turn all lights on at once
function ALL_ON {
	echo "Turning all lights on"
	for LED in $ALL_LED
	do
		$GPIO set $LED dh
	done
}

#####   Turning off lights       #####
function RED_OFF {
        $GPIO set $RED_LED dl
}
function YELLOW_OFF {
        $GPIO set $YELLOW_LED dl
}
function GREEN_OFF {
        $GPIO set $GREEN_LED dl
}
function BLUE_OFF {
        $GPIO set $BLUE_LED dl
}
### ALL_OFF : Turn all lights off at once
function ALL_OFF {
	echo "Turning lights off"
	for LED in $ALL_LED
	do
		$GPIO set $LED dl
	done
}

### L2H_ON : Turn on lights from low (red) to high (blue)
function L2H_ON {
	echo "Turning on light from low to high"
	for LED in $ALL_LED
	do
		$GPIO set $LED dh
		$SLEEP $SLIGHT_DELAY
	done
}

### L2H_OFF : Turn off lights from low (red) to high (blue)
function L2H_OFF {
	echo "Turning off light from low to high"
	for LED in $ALL_LED
	do
		$GPIO set $LED dl
		$SLEEP $SLIGHT_DELAY
	done
}

#### Add functions for high to low on and off

### TEST_ALL : Test each light one at a time
function TEST_ALL {
	echo "Testing each light"
	ALL_OFF
	RED_ON
	$SLEEP $DELAY
	RED_OFF
	$SLEEP $SLIGHT_DELAY
	YELLOW_ON
	$SLEEP $DELAY
	YELLOW_OFF
	$SLEEP $SLIGHT_DELAY
	GREEN_ON
	$SLEEP $DELAY
	GREEN_OFF
	$SLEEP $SLIGHT_DELAY
	BLUE_ON
	$SLEEP $DELAY
	BLUE_OFF
	$SLEEP $SLIGHT_DELAY
	ALL_OFF
}


### BLINK_ALL : No matter previous state, turn all off, blink five times, turn all off
function BLINK_ALL {
	echo "Blinking LEDs"
	ALL_OFF
	$SLEEP $SLIGHT_DELAY
	ALL_ON
	$SLEEP $SLIGHT_DELAY
	ALL_OFF
	$SLEEP $SLIGHT_DELAY
	ALL_ON
	$SLEEP $SLIGHT_DELAY
	ALL_OFF
	$SLEEP $SLIGHT_DELAY
	ALL_ON
	$SLEEP $SLIGHT_DELAY
	ALL_OFF
	$SLEEP $SLIGHT_DELAY
	ALL_ON
	$SLEEP $SLIGHT_DELAY
	ALL_OFF
	$SLEEP $SLIGHT_DELAY
	ALL_ON
	$SLEEP $SLIGHT_DELAY
	ALL_OFF
}

### Test all functions
SET_GPIO
GET_GPIO
TEST_ALL
$SLEEP $SLOW_DELAY
ALL_ON
$SLEEP $SLOW_DELAY
ALL_OFF
$SLEEP $SLOW_DELAY
L2H_ON
$SLEEP $SLOW_DELAY
L2H_OFF
$SLEEP $SLOW_DELAY
BLINK_ALL
