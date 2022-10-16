#!/bin/bash

. common.sh


if [[ -z $1 ]]; then
    echo "enter namespace"
    /usr/local/bin/kubectl get namespace
    exit 1
fi

for i do
  printf 'redeploy %s\n' "$i"

  namespace=$i
  
  for d in $(/usr/local/bin/kubectl get deployment -n $i | awk '{print $1}' | grep -v NAME)
  do
      echo "redeploying $d"
      restart $i $d
  done
done

exit

