#!/bin/bash

echo "Please make sure the device is connected."
# sleep 3
/Users/caleb/dev/sdks/andriod-platform-tools/adb connect 10.0.0.232
read -p "Enter back reboot or home: " command

CMD=0
case "$command" in
"back")
  CMD="input keyevent 4"
  ;;
"home")
  CMD="input keyevent 3"
  ;;
"reboot")
  CMD="reboot"
  ;;
*)
  echo "Error: command not allowed" && exit 1
  ;;
esac

/Users/caleb/dev/sdks/andriod-platform-tools/adb shell $CMD &
pid=$! # Process Id of the previous running command

spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null; do
  i=$(((i + 1) % 4))
  printf "\r executing ${spin:$i:1}"
  sleep .1
done
