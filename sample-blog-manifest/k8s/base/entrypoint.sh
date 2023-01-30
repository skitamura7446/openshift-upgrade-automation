#!/bin/bash

export BASE_DOMAIN=$(oc get ingresses.config/cluster -o jsonpath={.spec.domain})
envsubst < nginx-route-template.yaml > nginx-route.yaml
