#!/bin/sh

# http://alesnosek.com/blog/2017/02/14/accessing-kubernetes-pods-from-outside-of-the-cluster/

# When a pod is configured with hostNetwork: true, 
# the applications running in such a pod can directly see the network interfaces of the host machine where the pod was started. 
# An application that is configured to listen on all network interfaces will in turn be accessible on all network interfaces of the host machine

kubectl patch deployment nginx-ingress-controller -n ingress-nginx --patch '{"spec": {"template": {"spec": {"hostNetwork": true} } } }'