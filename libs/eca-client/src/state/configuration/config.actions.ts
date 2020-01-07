import {Action} from '@ngrx/store';

export const ConfigurationActions = {
  UPDATE_CONFIG: '[Configuration] Update',
  SECURITY_UPDATE_TOKEN: '[Configuration] Update Token',
  SECURITY_TOKEN_UPDATED: '[Configuration] Token Updated',
  APPLICATION_CONFIG: 'Application Configuration',
  APTTRIBUTE_GROUP_CONFIG: 'Attribute Group Configuration',
  CLIENT_CONFIG: 'Client Configuration',
};

export interface IConfigurationAction extends Action {
  payload?: object;
}

/* tslint:disable: max-classes-per-file */

export class UpdateConfig implements IConfigurationAction {
  readonly type = ConfigurationActions.UPDATE_CONFIG;

  constructor(public payload: object) {
  }
}

export class SecurityUpdateToken implements IConfigurationAction {
  readonly type = ConfigurationActions.SECURITY_UPDATE_TOKEN;
}

export class SecurityTokenUpdated implements IConfigurationAction {
  readonly type = ConfigurationActions.SECURITY_TOKEN_UPDATED;

  constructor(public payload: any) {
  }
}


export class ApplicationConfig implements IConfigurationAction {
  readonly type = ConfigurationActions.APPLICATION_CONFIG;

  constructor(public payload: object) {
  }
}

export class AttributeGroupConfig implements IConfigurationAction {
  readonly type = ConfigurationActions.APTTRIBUTE_GROUP_CONFIG;

  constructor(public payload: object) {
  }
}

export class ClientConfig implements IConfigurationAction {
  readonly type = ConfigurationActions.CLIENT_CONFIG;

  constructor(public payload: object) {
  }
}
