#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run this script as root/sudo"
  exit 1
fi

# Pass --kill as argument to kill all running cputhrottles
if [ $1 = "--kill" ]; then
  echo "Looking for running cputhrottles..."
  pids=`pidof cputhrottle`
  for pid in ${pids}; do
    echo "> Killing PID ${pid}"
    sudo kill ${pid}
  done
  echo "Done!"
  exit 0
fi

declare -a applications

# Syntax='application;max-cpu'
applications[0]='Backup\ and\ Sync;30'
# applications[1]='Firefox;50'
# applications[2]='pycharm;40'
# applications[3]='webstorm;40'
# applications[4]='Safari;35'

for i in "${applications[@]}"; do
  app=(${i//;/ })
  app_name=${app[0]}
  cpu_limit=${app[1]}

  printf "\nLooking for ${app_name}...\n"
  pids=`pidof ${app}`
  for pid in ${pids}; do
    echo "> PID=${pid}, CPU=${cpu_limit}"
    sudo cputhrottle ${pid} ${cpu_limit} &
  done
done

printf "\nDone!\n"
echo "Run this script passing '--kill' as argument to remove all cputhrottles."
