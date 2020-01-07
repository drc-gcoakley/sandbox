import {Component, NgZone, OnInit} from '@angular/core';
import {Store} from '@ngrx/store';
import {isEmpty} from 'lodash/fp';
import {Observable} from 'rxjs/Observable';
import '../rxjs-operators';
import {ScriptLoaderService} from '../services/script-loader.service';
import {IConfig} from '../services/configuration.service';

@Component({
  selector: 'eca-portal-header',
  templateUrl: './eca-header.component.html',
  styleUrls: ['./eca-header.component.css'],
})
export class EcaHeaderComponent implements OnInit {

  config$: Observable<IConfig>;
  token$: Observable<string>;

  constructor(private store: Store<any>,
              private scriptLoader: ScriptLoaderService,
              private zone: NgZone) {
    this.config$ = this.store.select('config');
    this.token$ = this.store.select('token');
  }

  static getWindowPortalHeaderObject(): any {
    const eph = window['ECA_PORTAL_HEADER'];
    if (eph) {
      return eph;
    } else {
      throw Error('Cannot find \'ECA_PORTAL_HEADER\' in browser window.');
    }
  }

  ngOnInit() {
    Observable.combineLatest(
      this.config$,
      this.token$,
    )
      .filter(([config, token]) => {
        return !isEmpty(config);
      })
      .first()
      .subscribe(async ([config, token]) => {
        await this.scriptLoader.load(config.portalHeaderLibUrl);
        this.initializePortalHeader(config.client, token);
      });
  }

  initializePortalHeader(clientAbbreviation, token) {
    // not sure yet if we need to run this outside
    // of angular's zones, but trying it for now.
    this.zone.runOutsideAngular((self: this) => {
      EcaHeaderComponent.getWindowPortalHeaderObject()
        .init({clientAbbreviation, token});
    });
  }
}
