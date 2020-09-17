#!/bin/bash

#Import variable files
BUILD_VARIABLES_PATH="/home/brett/k8s-deploy/packer/build-variables.json"
ENVIRONMENT_VARIABLES_PATH="/home/brett/k8s-deploy/environment-variables.json"
BUILD_FILE_PATH="/home/brett/k8s-deploy/packer/build.json"
BUILD_VARIABLES=$(cat $BUILD_VARIABLES_PATH)
ENVIRONMENT_VARIABLES=$(cat $ENVIRONMENT_VARIABLES_PATH)

if [[ $(echo $BUILD_VARIABLES | python3 -c "import sys, json; print(json.load(sys.stdin)['append_commit_hash'])") = "true" ]]; then
  COMMIT_SHORT_HASH=$(git rev-parse --short HEAD)
  TEMPLATE_NAME="$(echo $BUILD_VARIABLES | python3 -c "import sys, json; print(json.load(sys.stdin)['vm_template_name_prefix'])")-$COMMIT_SHORT_HASH"
else
  TEMPLATE_NAME="$(echo $BUILD_VARIABLES | python3 -c "import sys, json; print(json.load(sys.stdin)['vm_template_name_prefix'])")"
fi

BUILD_CMD="packer build -var-file=$BUILD_VARIABLES_PATH -var-file=$ENVIRONMENT_VARIABLES_PATH -var 'vm_template_name=${TEMPLATE_NAME}'"

if [[ $(echo $BUILD_VARIABLES | python3 -c "import sys, json; print(json.load(sys.stdin)['overwrite_existing'])") = "true" ]]; then
  BUILD_CMD="${BUILD_CMD} -force"
fi

BUILD_CMD="${BUILD_CMD} $BUILD_FILE_PATH"

echo $BUILD_CMD
$BUILD_CMD
