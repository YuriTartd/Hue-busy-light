#!/bin/sh
#Variables
lightNum=1 #perform a GET to $hueBridge/api/$apiKey/lights to retrieve
selection=0 #Default value for loop
status=unknown #Default status
apiKey= 
hueBridge= #bridge IP address
#Start loop
while [[ selection -le 3 ]]
  do
  clear
#Display options/status and collect user input
  echo "
  Status: $status

  Select from the following:
  1. Busy
  2. Not Busy
  3. Change Light
  4. Exit"
  read -e selection

#Set light red and change status to busy
  if [[ $selection -eq 1 ]]
    then
      curl -s -X PUT -d '{"on": true,"bri": 150,"hue": 60,"sat": 245}' http://$hueBridge/api/$apiKey/lights/$lightNum/state > /dev/null
      echo "You are busy"
      status=Busy
    fi
#Change light green and change status to Available
    if [[ $selection -eq 2 ]]
    then
      curl -s -X PUT -d '{"on": true,"bri": 150,"hue": 25600,"sat": 254}' http://$hueBridge/api/$apiKey/lights/$lightNum/state > /dev/null
      echo "You are not busy"
      status=Available
    fi
#Change light selection
    if [[ $selection -eq 3 ]]
    then
      echo "Change Light?"
      read -e lightNum
    fi
#Exit
    if [[ $selection -eq 4 ]]
      then echo "Exiting"
    fi
done
