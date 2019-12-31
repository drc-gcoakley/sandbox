#!/bin/sh

for s in dev sqa stg; do 
   echo "Packaging stage $s..."
   npx sls package --stage $s --package ./sls-pkg-$s | tee sls-package-$s.log
done

