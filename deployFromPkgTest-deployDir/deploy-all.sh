#!/bin/sh -x

for s in stg; do 
   echo "Deploying stage $s..."
   npx sls deploy --stage $s --package ./sls-pkg-$s | tee sls-deploy-$s.log
done

