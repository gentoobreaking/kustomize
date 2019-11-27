kustomize usgae
===
![downloads](https://img.shields.io/github/downloads/atom/atom/total.svg)
![build](https://img.shields.io/appveyor/ci/:user/:repo.svg)
![chat](https://img.shields.io/discord/:serverId.svg)

## Table of Contents

[TOC]

---

## Install kustomize in MacOS

```gherkin=
brew search kustomize
brew install kustomize
```

## Hello world testing

```gherkin=
mkdir -p kustomize/helloworld-example && cd kustomize/
export DEMO_HOME=$(pwd)/helloworld-example
echo $DEMO_HOME
export BASE=$DEMO_HOME/base
mkdir -p $BASE
curl -s -o "$BASE/#1.yaml" "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/examples/helloWorld/{configMap,deployment,kustomization,service}.yaml"
find $DEMO_HOME -type f
kustomize build $BASE
```

### Deploy (ensuring the new change use.)
```gherkin=
kustomize build $BASE | kubectl apply -f -
```

### Verify
```gherkin=
kubectl get po,svc,cm
```

### 建立 Overlay 資料夾
```gherkin=
export OVERLAYS=$DEMO_HOME/overlays
mkdir -p $OVERLAYS/staging
mkdir -p $OVERLAYS/softlanch
mkdir -p $OVERLAYS/production
```

### Make the kustomization.yaml for staging
```gherkin=
cat <<EOF > $OVERLAYS/staging/kustomization.yaml
namePrefix: staging-
commonLabels:
  variant: staging
  org: Funpodium Corporation
commonAnnotations:
  note: Hello, I am staging!
bases:
- ../../base
patches:
- map.yaml
EOF
```

### Make the patch for staging
```gherkin=
cat <<EOF > $OVERLAYS/staging/map.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: the-map
data:
  altGreeting: "Have a pineapple!"
  enableRisky: "true"
EOF
```

### Make the kustomization.yaml for production
```gherkin=
cat <<EOF > $OVERLAYS/production/kustomization.yaml
namePrefix: production-
commonLabels:
  variant: production
  org: acmeCorporation
commonAnnotations:
  note: Hello, I am production!
bases:
- ../../base
patches:
- deployment.yaml
EOF
```

### Make change for replicas in Production
```gherkin=
cat <<EOF > $OVERLAYS/production/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: the-deployment
spec:
  replicas: 5
EOF
```

### Deploy for Staging
```gherkin=
kustomize build $OVERLAYS/staging | kubectl apply -f -
```

### Deploy for Production
```gherkin=
kustomize build $OVERLAYS/production | kubectl apply -f -
```

# --- END --- #
