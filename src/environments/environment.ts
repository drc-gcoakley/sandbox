// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `.angular-cli.json`.

export const environment = {
  production: false,
  protractor: false,
  localapi: false,
  hmr: false,
  apiGatewayConfig: {
    apiGatewayUrl: 'https://api-gateway-dev.drcedirect.com/',
    apiGatewayCloudUrl: 'https://api-gateway-cloud-dev.drcedirect.com',
    deployment: 'development',
    enableCache: false,
  },
  portalUrl: 'https://cdn-app-dev.drcedirect.com/all/eca-portal-v2-ui/#/login',
  localScanningWebApi: `https://api-gateway-cloud-dev.drcedirect.com/eca-local-scanning-web-api/tabe-development-v0/v0`,
  dynamsoftResourcesPath: `https://api-gateway-cloud-dev.drcedirect.com/eca-local-scanning-web-ui/all-development-v0/Resources`,
};
