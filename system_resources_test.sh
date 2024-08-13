#!bin/bash

#create a baash script that checks for system resources (memory,cpu, disk)
# make sure you use conditionals statements and use exit code 0 or 1

cpuThreshold = 60
memThreshold = 60
diskThreshold = 60

#To Check CPU Usage

#CPU Idle time checks the precentage of Idle CPU time. 
#top -bn1 grabs real time snapshot of system processes and pipes it to grep.
#Grep then searches for any lines containing CPUs 
#The output of grep is piped to awk which prints the 8th line that contains the idle CPU time  
cpuIdleTime=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')

#CPU used is  calculated by subtracting the idle time from 100.
#the result is piped to bc (Basic Calcultor) because it is best for handling float expressions. 
cpuUsed=$(echo "100 - $CPU_IDLE" | bc)
  
  if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "CPU usage is above threshold: $CPU_USAGE%"
    return 1
  else
    echo "CPU usage is within limits: $CPU_USAGE%"
    return 0
  fi


