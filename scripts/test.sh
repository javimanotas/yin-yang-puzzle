#!/bin/bash

total_time=0

for i in $(seq -f "%02g" 1 11); do
  echo "---------------------"
  echo "Running decode $i..."
  user_time=$((time make decode $i) 2>&1 | grep "user" | awk -F'm' '{print $1*60*1000 + $2*1000}' )
  total_time=$((total_time + user_time))
  
  if cmp -s "sol$i.txt" "examples/sol$i.txt"; then
    echo "Test dom$i passed"
      rm -f "dom$i.lp"
      rm -f "sol$i.txt"
  else
    echo "Test dom$i failed"
    break
  fi
   echo "User time: $user_time ms"
  echo "---------------------"
done

echo "---------------------"
echo "Total TUser: $total_time ms"
echo "---------------------"
