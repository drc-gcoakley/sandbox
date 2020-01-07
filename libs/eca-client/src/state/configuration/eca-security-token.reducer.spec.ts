import {SecurityTokenUpdated} from './config.actions';
import {ecaSecurityTokenReducer} from './eca-security-token.reducer';

describe('ecaSecurityTokenReducer', () => {
  describe('ConfigurationActions.SECURITY_TOKEN_UPDATED', () => {
    it('should return the state with the updated token', () => {
      const action = new SecurityTokenUpdated('abc');

      const newState = ecaSecurityTokenReducer('123', action);

      expect(newState).toEqual('abc');
    });
  });
});
