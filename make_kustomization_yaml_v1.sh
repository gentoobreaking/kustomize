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
ls -l *.yaml | grep -v ingress | egrep -v 'kustomization|namespace|mapping|deployment|service|hpa|configMap' | awk '{print "- "$9}'

echo -e "\n# Namespcace:"
ls -l *.yaml | grep -v ingress | grep '\-namespace.yaml' | awk '{print "- "$9}'

echo -e "\n# Secrets:"
ls -l *.yaml | grep -v ingress | grep '\-secrets.yaml' | awk '{print "- "$9}'

echo -e "\n# ConfigMap:"
ls -l *.yaml | grep -v ingress | grep '\-configmap.yaml' | awk '{print "- "$9}'

echo -e "\n# Mapping:"
ls -l *.yaml | grep -v ingress | grep 'mapping\-' | awk '{print "- "$9}'

echo -e "\n# Deployment:"
ls -l *.yaml | grep -v ingress | grep '\-deployment.yaml' | awk '{print "- "$9}'

echo -e "\n# Service:"
ls -l *.yaml | grep -v ingress | grep '\-servie.yaml' | awk '{print "- "$9}'

echo -e "\n# Hpa:"
ls -l *.yaml | grep -v ingress | grep '\-hpa.yaml' | awk '{print "- "$9}'

echo -e "\n# --- END --- #"
}

make_kustomization_yaml > ./kustomization.yaml
echo " - output file: $(ls -l ./kustomization.yaml)"

# --- END --- #
