import {SecurityService} from '../../services/security.service';
import {Injectable} from '@angular/core';
import {Action} from '@ngrx/store';
import {Actions, Effect} from '@ngrx/effects';
import {Observable} from 'rxjs/Observable';
import '../../rxjs-operators';
import {isEmpty, pick} from 'lodash/fp';
import {EcaHeaderComponent} from '../../eca-header/eca-header.component';

import {ConfigurationActions, IConfigurationAction, SecurityTokenUpdated,} from './config.actions';


@Injectable()
export class ConfigEffects {

  @Effect() updateToken$: Observable<Action> = this.actions$.ofType(ConfigurationActions.SECURITY_UPDATE_TOKEN)
    .switchMap((action: IConfigurationAction) => {
      return this.securityService.refreshToken();
    })
    .switchMap((response: any) => {
      EcaHeaderComponent.getWindowPortalHeaderObject().refresh(response.token);
      return Observable.of(new SecurityTokenUpdated(response.token));
    });

  constructor(private actions$: Actions,
              private securityService: SecurityService) {
  }
}
