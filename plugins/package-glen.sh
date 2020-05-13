#!/bin/sh
cd $(dirname $0)/..
ROOT_DIR=$(pwd)
WORK_DIR=${ROOT_DIR}/tmp/
mkdir -p $WORK_DIR
cd $WORK_DIR

for stage in glen1 ;do #glen2; do
  for region in us-east-1 ;do #us-east-2; do
    for stack in data ;do #lambda; do
      pkgDir=sls_pkg_${stage}_${region}_${stack}
      mkdir -p $WORK_DIR/${pkgDir}
      cd $WORK_DIR/${pkgDir}
      cp -rp $ROOT_DIR/.serverless_plugins $ROOT_DIR/serverless/webpack.config.js .
      echo_do npx sls print \
              --pathToPkgRoot ../.. --config ../../serverless_${stack}.yml \
              --package $pkgDir --stage $stage --region $region > ${pkgDir}.log &
      npx sls package \
              --pathToPkgRoot ../.. --config ../../serverless_${stack}.yml \
              --package $pkgDir --stage $stage --region $region &
    done
  done
done

jobs
wait
ls -l sls_pkg_*
