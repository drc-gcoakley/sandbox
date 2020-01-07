import {Subscription} from 'rxjs/Subscription';
import {Observable} from 'rxjs/Observable';
import {Component, NgZone} from '@angular/core';
import {ConfigurationService, IConfig} from '../services/configuration.service';
import {OnDestroy, OnInit} from '@angular/core/src/metadata/lifecycle_hooks';
import {Store} from '@ngrx/store';
import {SecurityUpdateToken} from '../state/configuration/config.actions';
import {isEmpty} from 'lodash/fp';

@Component({
  selector: 'eca-portal',
  templateUrl: './portal-container.component.html',
  styleUrls: ['./portal-container.component.css'],
})
export class EcaPortalAppContainerComponent implements OnInit, OnDestroy {

  refreshTokenSubscription: Subscription;
  title = '';

  constructor(private configService: ConfigurationService, private _store: Store<any>, private _ngZone: NgZone) {

    this.configService.consumeConfigJson();
    this.validateConfigurationValues(_store);
    this.startSSOTokenRefresh();
  }

  ngOnInit() {
  }

  ngOnDestroy() {
    this.refreshTokenSubscription.unsubscribe();
  }

  private validateConfigurationValues(_store: Store<any>) {
    // Set the application title read from the configuration file.
    const config = _store.select('config');
    config.map((configJson: IConfig) => configJson.portalAppTitle)
      .filter((titleText) => !isEmpty(titleText))
      .subscribe((value) => this.title = value,
        (error) => new Error('All DRC Portal applications must define a title.'));
  }

  private startSSOTokenRefresh() {
    this._ngZone.runOutsideAngular(() => {
      this.refreshTokenSubscription = Observable
        .interval(60 * 1000)
        .withLatestFrom(this._store.select('token'))
        .switchMap(([, token]) => {
            if (token) {
              this._store.dispatch(new SecurityUpdateToken());
            }
            return Observable.of(null);
          },
        ).subscribe();
    });
  }

}
