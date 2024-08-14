#!bin/bash

#create a baash script that checks for system resources (memory,cpu, disk)
# make sure you use conditionals statements and use exit code 0 or 1

cpuThreshold = 60
memThreshold = 60
diskThreshold = 60

#To Check CPU Usage

#CPU Idle time checks the precentage of Idle CPU time. 
#top -bn1 grabs real time snapshot of system processes and pipes it to grep.
#Grep then takes the output from top -bn1 and  searches it for any lines containing CPUs 
#The output of grep is piped to awk which prints the 8th line that contains the idle CPU time  
cpuIdleTime=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')

#CPU used is  calculated by subtracting the idle time from 100.
#the result is piped to bc (Basic Calcultor) because it is best for handling float expressions. 
cpuUsed=$(echo "100 - $cpuUsed" | bc)
  
#If the Cpu Usage is greater than the threshhold, it will return an exit code of 1. 
#Exit code 1 is for generic errors. In this case: The error is the CPU Usage is above the threshold. 
#If it is within the threshold, it will return an exit code of 0, which means the the threshold is within limits and is a succesful execution. 
   if [ "$cpuUsed" -gt "$cpuThreshold" | bc -l ];
   then
      echo "CPU usage is above threshold: $cpuUsed%"
      return 1
  else
     echo "CPU usage is within limits: $cpuUsed%"
     return 0
  fi

#To Check Memory Usage
 
#Memory Used: The free command is used to show all of the memory usage 
#stats. That information is piped to grep 'mem'. This searches only 
#for the lines that contain the word 'mem'. Once that output
#is recieved, the 3rd column is printed which is the Memory Used 
#column
  memUsed=$(free | grep Mem | awk '{print $3}')

#Memory Total: The free command is used again to show all of the 
#memory usage stats. That output is then piped to search for 
#lines containing 'Mem'. That output is then piped so it 
#prints only the 2nd column which is the Memory Total  

  memTotal=$(free | grep Mem | awk '{print $2}')

#Memory Usage: Divides the memory used by the memory total and
#multiples it by 100 to convert it into a percentage. that 
#output is piped to bc (basic Calculator) because it handle 
#floating point  expressions. 
  memUsage=$(echo "$memUsed  / $memTotal * 100" | bc)
  
  if [ "$memUsage" -gt "$memThreshold" | bc -l ];
  then
     echo "Memory usage is above threshold: $memUsage%"
     return 1
  else
     echo "Memory usage is within limits: $memUsage%"
    return 0
  fi

#To check Disk Usage
diskUsed=$(df / | grep / | awk '{print $5}' | sed 's/%//')
  
  if [ "$diskUsed" -gt "$diskThreshold" ];
   then
    echo "Disk usage is above threshold: $diskUsed%"
    return 1
  else
    echo "Disk usage is within limits: $diskUsed%"
    return 0
  fi
