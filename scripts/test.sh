#!/bin/bash

for i in $(seq -f "%02g" 1 11); do
  echo "---------------------"
  echo "Running decode $i..."
  user_time=$((time make decode $i) 2>&1 | grep "user" | cut -f2)
  
  if cmp -s "sol$i.txt" "examples/sol$i.txt"; then
    echo "Test dom$i passed"
      rm -f "dom$i.lp"
      rm -f "sol$i.txt"
  else
    echo "Test dom$i failed"
    break
  fi
   echo "User time: $user_time"
  echo "---------------------"
done
