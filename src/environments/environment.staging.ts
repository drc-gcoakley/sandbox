
export const environment = {
  production: false,
  protractor: false,
  localapi: false,
  hmr: false,
  apiGatewayConfig: {
    apiGatewayUrl: 'https://api-gateway-staging.drcedirect.com/',
    apiGatewayCloudUrl: 'https://api-gateway-cloud-staging.drcedirect.com',
    deployment: 'staging',
    enableCache: false,
  },
  portalUrl: 'https://cdn-app-staging.drcedirect.com/all/eca-portal-v2-ui/#/login',
  localScanningWebApi: `https://api-gateway-cloud-staging.drcedirect.com/eca-local-scanning-web-api/tabe-staging-v0/v0`,
  dynamsoftResourcesPath: `https://api-gateway-cloud-sqa.drcedirect.com/eca-local-scanning-web-ui/all-sqa-v0/Resources`,
  securityServiceApi: 'https://api-gateway-staging.drcedirect.com/eca-security-service/all-staging-v0',
};
