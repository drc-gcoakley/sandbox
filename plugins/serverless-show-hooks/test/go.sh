set -x
SLS_DEBUG=t

npx sls path -c serverless.yml --help
npx sls hooks -c serverless.yml --help

npx sls hooks -c serverless.yml
npx sls path dump -c serverless.yml

npx sls print -c serverless.yml
npx sls package -c serverless.yml

