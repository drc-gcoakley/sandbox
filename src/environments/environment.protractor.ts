export const environment = {
  production: false,
  protractor: true,
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
