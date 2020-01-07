export const environment = {
  production: true,
  protractor: false,
  localapi: false,
  hmr: false,
  apiGatewayConfig: {
    apiGatewayUrl: 'https://api-gateway.drcedirect.com/',
    apiGatewayCloudUrl: 'https://api-gateway-cloud.drcedirect.com',
    deployment: 'production',
    enableCache: false,
  },
  portalUrl: 'https://www.drcedirect.com/all/eca-portal-v2-ui/#/login',
  localScanningWebApi: `https://api-gateway-cloud.drcedirect.com/eca-local-scanning-web-api/tabe-production-v0/v0`,
  dynamsoftResourcesPath: `https://api-gateway-cloud.drcedirect.com/eca-local-scanning-web-ui/all-production-v0/Resources`,
};
