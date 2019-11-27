#!/bin/bash

export BASE="$(pwd | awk -F'/' '{print $NF}')"
echo " - BASE:${BASE}"

make_kustomization_yaml()
{
echo "# ${BASE} configuration by David's scripting automatic making.
commonLabels:
  app: ${BASE}

resources:"

echo -e "\n# Others:"
find . -type f -name '*.yaml' | grep -v ingress | egrep -v 'kustomization|namespace|mapping|deployment|service|hpa|configMap' | awk '{print "- "$1}'

echo -e "\n# Namespcace:"
find . -type f -name '*-namespace.yaml' | awk '{print "- "$1}'

echo -e "\n# Secrets:"
find . -type f -name '*-secrets.yaml' | awk '{print "- "$1}'

echo -e "\n# ConfigMap:"
find . -type f -name '*-configmap.yaml' | awk '{print "- "$1}'

echo -e "\n# Mapping:"
find . -type f -name 'mapping-*.yaml' | awk '{print "- "$1}'

echo -e "\n# Deployment:"
find . -type f -name '*-deployment.yaml' | awk '{print "- "$1}'

echo -e "\n# Service:"
find . -type f -name '*-service.yaml' | awk '{print "- "$1}'

echo -e "\n# Hpa:"
find . -type f -name '*-hpa.yaml' | awk '{print "- "$1}'

echo -e "\n# --- END --- #"
}

make_kustomization_yaml > ./kustomization.yaml
echo " - output file: $(ls -l ./kustomization.yaml)"

# --- END --- #
