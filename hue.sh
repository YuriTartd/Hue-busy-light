#!/bin/sh
#Variables
lightNum=
selection=0
status=
apiKey=
hueBridge=
#Start loop
while [ $selection -le 5 ]
  do
  clear
#Display options/status and collect user input
  echo "
  Status: $status

  Select from the following:
  1. Busy
  2. Available
  3. Soft White
  4. Off
  5. Change Light selection
  6. Exit"
  read -e selection

#Set light red and change status to busy
  if [ $selection -eq 1 ]
    then
      curl -s -X PUT -d '{"on": true,"bri": 100,"hue": 60,"sat": 245}' http://$hueBridge/api/$apiKey/lights/$lightNum/state > /dev/null
      echo "You are busy"
      status=Busy
    fi
#Change light green and change status to Available
    if [ $selection -eq 2 ]
     then
      curl -s -X PUT -d '{"on": true,"bri": 100,"hue": 25600,"sat": 254}' http://$hueBridge/api/$apiKey/lights/$lightNum/state > /dev/null
      echo "You are not busy"
      status=Available
    fi
#Change light back to normal
    if [ $selection -eq 3 ]
      then
	     curl -s -X PUT -d '{"on": true,"bri": 100,"hue": 8382,"sat":140}' http://$hueBridge/api/$apiKey/lights/$lightNum/state > /dev/null
	     echo  "Soft White"
	     status=SoftWhite
    fi
#Turn light off
    if [ $selection -eq 4 ]
      then
	      curl -s -X PUT -d '{"on": false}' http://$hueBridge/api/$apiKey/lights/$lightNum/state > /dev/null
	      echo  "Off"
	      status=Off
    fi
#Change light selection
    if [ $selection -eq 5 ]
     then
      echo "Change Light?"
      read -e lightNum
    fi
#Exit
    if [ $selection -eq 6 ]
      then echo "Exiting"
    fi
done
