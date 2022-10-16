# usage watch_deployment <namespace> <deployment name> waits for deployment to reach ready state
watch_deployment() {
  finished=0
  while [ $finished -eq 0 ]; do
    sleep 1
    not_ready=$(/usr/local/bin/kubectl get deployment $2 -n $1 -o jsonpath='{.status.unavailableReplicas}')
    if [ -z $not_ready ]; then
      echo "deployment $1/$2 now ready"
      finished=1
    else
      echo "still waiting for $1/$2..."
      sleep 4
    fi
  done
}

# usage scale_up <namespace> <deployment name>
scale_up() {
  echo "scaling $1/$2 up"
  /usr/local/bin/kubectl scale deployment $2 --replicas=1 -n $1
  watch_deployment $1 $2
}

# usage scale_down <namespace> <deployment name>
scale_down() {
  echo "scaling $1/$2 up"
  /usr/local/bin/kubectl scale deployment $2 --replicas=0 -n $1
}

# usage restart <namespace> <deployment name>
restart() {
  echo "restarting $1/$2"
  /usr/local/bin/kubectl rollout restart deployment/$2 -n $1
  watch_deployment $1 $2
}

