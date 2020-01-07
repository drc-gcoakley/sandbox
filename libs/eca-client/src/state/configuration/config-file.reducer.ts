import {ConfigurationActions, IConfigurationAction} from './config.actions';
import {IConfig} from '../../services/configuration.service';

export function configFileReducer(state: IConfig, action: IConfigurationAction) {
  switch (action.type) {
    // Since client selection is done from the DRC Portal, `client`
    // will probably never be updated from within this application.

    case ConfigurationActions.UPDATE_CONFIG:
      return {
        ...state,
        ...action.payload,
      };

    default:
      return state;

  }
}
