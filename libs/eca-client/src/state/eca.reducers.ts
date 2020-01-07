import {ActionReducerMap} from '@ngrx/store';

import {configFileReducer} from './configuration/config-file.reducer';
import {ecaSecurityTokenReducer} from './configuration/eca-security-token.reducer';
import {sessionReducer} from './session/session.reducer';

export const ecaReducers: ActionReducerMap<any> = {
  config: configFileReducer,
  token: ecaSecurityTokenReducer,
  session: sessionReducer,
};
