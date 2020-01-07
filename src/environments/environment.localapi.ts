export const environment = {
  production: false,
  protractor: false,
  localapi: true,
  hmr: false,
  apiGatewayConfig: {
    apiGatewayUrl: 'https://api-gateway-dev.drcedirect.com/',
    apiGatewayCloudUrl: 'https://api-gateway-cloud-dev.drcedirect.com',
    deployment: 'development',
    enableCache: false,
  },
  portalUrl: 'https://cdn-app-dev.drcedirect.com/all/eca-portal-v2-ui/#/login',
  localScanningWebApi: 'http://localhost:8080/v0',
  dynamsoftResourcesPath: `http://localhost:4200/assets/MockResources`,
};
