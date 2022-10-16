#!/bin/bash

. common.sh


if [[ -z $1 ]]; then
    echo "enter namespace"
    /usr/local/bin/kubectl get namespace
    exit 1
fi

if [[ -z $2 ]]; then
    echo "enter deployment (multiple with space)"
    /usr/local/bin/kubectl get deployment -n $1
    exit 1
fi


iter=0
count=$(expr $(echo $* | wc -w) - 1)
for i do
  if [[ $iter -eq 0 ]]; then
      namespace=$1
  else
    echo
    echo "$iter/$count : scaling down $namespace/$i"
    scale_down $namespace $i
  fi
  iter=$(expr $iter + 1)
done

exit

