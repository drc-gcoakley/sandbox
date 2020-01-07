import {ConfigurationActions} from './config.actions';

export function ecaSecurityTokenReducer(token: string, action: any) {
  switch (action.type) {

    case ConfigurationActions.SECURITY_TOKEN_UPDATED:
      return action.payload;

    default:
      return token;
  }
}


