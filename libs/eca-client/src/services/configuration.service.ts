import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Store} from '@ngrx/store';
import {
  ApplicationConfig,
  AttributeGroupConfig,
  ClientConfig,
  UpdateConfig
} from '../state/configuration/config.actions';

export interface IConfig {
  client: string;     // TODO rename this toClientName/clientId/clientAbbr/clientAbbreviation...
  portalHeaderLibUrl: string;
  portalAppTitle: string;
  securityServiceApiUrl: string;
  portalAppApiUrl: string;
  configEndpointUrl: string;      // "https://api-gateway-sqa.drcedirect.com/eca-setup-configuration-service/all-sqa-v0/v0",
  configUrlPathForApp: string;    // "${configEndpointUrl}/applications/${appId}",
  configUrlPathForGroups: string; // "${configEndpointUrl}/attribute-groups/${groupId}",
  configUrlPathForClient: string; // "${configEndpointUrl}/clients/${clientId}/attributes",
}

@Injectable()
export class ConfigurationService {

  // TODO this should be in a utility class. -Glen
  private expandVariablesIntoTemplate = (template, varsObject) => {
    return template.replace(/\${(\w+)}/g, (_, propertyName) => varsObject[propertyName]);
  }

  constructor(private http: HttpClient, private store: Store<any>) {
  }

  consumeConfigJson() {
    this.http.get<IConfig>('config.json')
      .subscribe(
        jsonResponseIfSuccessful => {
          this.store.dispatch(new UpdateConfig(jsonResponseIfSuccessful));
        },
        errorResponseIfFailed => {
          if (errorResponseIfFailed.status === 404) {
            console.log('No application defined app/src/config.json.');
          } else {
            throw errorResponseIfFailed;
          }
        }
      );
  }

  /** This is untested. */
  getApplicationConfig(appId: string, config: IConfig): void {
    const variables = this.cloneObject(config);
    variables['appId'] = appId;
    const fullUrl = this.expandVariablesIntoTemplate(config.configUrlPathForApp, variables);

    this.http.get<IConfig>(fullUrl).subscribe(
      jsonResponseIfSuccessful => {
        this.store.dispatch(new ApplicationConfig(jsonResponseIfSuccessful));
      },
      errorResponseIfFailed => {
        throw errorResponseIfFailed;
      }
    );
  }

  /** This is untested. */
  getAttributeGroupConfig(groupId: string, config: IConfig): void {
    const variables = this.cloneObject(config);
    variables['groupId'] = groupId;
    const fullUrl = this.expandVariablesIntoTemplate(config.configUrlPathForGroups, variables);

    this.http.get<IConfig>(fullUrl).subscribe(
      jsonResponseIfSuccessful => {
        this.store.dispatch(new AttributeGroupConfig(jsonResponseIfSuccessful));
      },
      errorResponseIfFailed => {
        throw errorResponseIfFailed;
      }
    );
  }

  /** This is untested. */
  getClientConfig(clientId: string, config: IConfig): void {
    const variables = this.cloneObject(config);
    variables['clientId'] = clientId;
    const fullUrl = this.expandVariablesIntoTemplate(config.configUrlPathForClient, variables);

    this.http.get<IConfig>(fullUrl).subscribe(
      jsonResponseIfSuccessful => {
        this.store.dispatch(new ClientConfig(jsonResponseIfSuccessful));
      },
      errorResponseIfFailed => {
        throw errorResponseIfFailed;
      }
    );
  }

  // TODO this should be in a utility class. -Glen
  private cloneObject(source: object): object {
    return Object.assign({}, source);
  }
}
