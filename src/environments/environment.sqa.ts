
export const environment = {
  production: false,
  protractor: false,
  localapi: false,
  hmr: false,
  apiGatewayConfig: {
    apiGatewayUrl: 'https://api-gateway-sqa.drcedirect.com/',
    apiGatewayCloudUrl: 'https://api-gateway-cloud-sqa.drcedirect.com',
    deployment: 'sqa',
    enableCache: false,
  },
  portalUrl: 'https://cdn-app-sqa.drcedirect.com/all/eca-portal-v2-ui/#/login',
  localScanningWebApi: `https://api-gateway-cloud-sqa.drcedirect.com/eca-local-scanning-web-api/tabe-sqa-v0/v0`,
  dynamsoftResourcesPath: `https://api-gateway-cloud-sqa.drcedirect.com/eca-local-scanning-web-ui/all-sqa-v0/Resources`,
};
