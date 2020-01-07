import {async, ComponentFixture, TestBed} from '@angular/core/testing';
import {RouterTestingModule} from '@angular/router/testing';
import {Store, StoreModule} from '@ngrx/store';
import {Observable} from 'rxjs/Observable';

import {EcaPortalAppContainerComponent} from './portal-container.component';
import {EcaHeaderComponent} from '../eca-header/eca-header.component';
import {EcaFooterComponent} from '../eca-footer/eca-footer.component';

import {ecaReducers} from '../state/eca.reducers';
import {SecurityUpdateToken} from '../state/configuration/config.actions';

import {ScriptLoaderService} from '../services/script-loader.service';
import {ConfigurationService} from '../services/configuration.service';
import {HttpClientTestingModule} from '@angular/common/http/testing';

class ScriptLoaderServiceMock {
  load(url) {
    console.log(`App mock pretending to load ${url}`);
    if (url.match(/header/)) {
      // This is a bit naughty accessing the EcaHeaderComponent's privates.
      window['ECA_PORTAL_HEADER'] = {
        init: () => {
        },
      };
    }
    return Promise.resolve();
  }
}

function getInitialState(token = 'THEENCHANTER') {
  return {
    // Set properties of an IConfig object needed for these tests.
    config: {
      client: 'TIM',
      portalHeaderLibUrl: 'fake.portal.header.url',
      portalAppTitle: 'fake application name',
      portalAppApiUrl: 'fake.web.api.url',
    },
    token,
  };
}

function setupTestBed(initialStateObject) {
  TestBed.configureTestingModule({
    imports: [
      RouterTestingModule,
      StoreModule.forRoot(ecaReducers, {initialState: initialStateObject}),
      HttpClientTestingModule,
    ],
    declarations: [
      EcaPortalAppContainerComponent,
      EcaHeaderComponent,
      EcaFooterComponent,
    ],
    providers: [
      ConfigurationService,
      {provide: ScriptLoaderService, useClass: ScriptLoaderServiceMock},
    ],
  }).compileComponents();
}

describe('EcaPortalAppContainerComponent', () => {
  let app: EcaPortalAppContainerComponent;
  let fixture: ComponentFixture<EcaPortalAppContainerComponent>;
  let store: Store<any>;

  function setupSpies() {
    // This spy is just for 'should dispatch a refresh token event after timer' and
    // 'token undefined'. 10 = The timer interval
    spyOn(Observable, 'interval').and.returnValue(Observable.of(10));

    store = TestBed.get(Store);
    spyOn(store, 'dispatch').and.callThrough();
    fixture = TestBed.createComponent(EcaPortalAppContainerComponent);
    app = fixture.componentInstance;
    fixture.detectChanges();

    spyOn(app.refreshTokenSubscription, 'unsubscribe').and.callThrough();
  }

  describe('token defined', () => {
    beforeEach(async(() => setupTestBed(getInitialState())));

    beforeEach(setupSpies);

    it('should create the app', async(() => {
      expect(app).toBeTruthy();
    }));

    it(`should have a title as defined in the config.json`, async(() => {
      expect(app.title).toEqual('fake application name');
    }));

    it('should set refreshTokenSubscription to a subscription on load', async(() => {
      expect(app.refreshTokenSubscription).toBeDefined();
    }));

    it('should unsubscribe after ngOnDelete', async(() => {
      app.ngOnDestroy();
      expect(app.refreshTokenSubscription.unsubscribe).toHaveBeenCalled();
    }));

    it('should dispatch a refresh token event after timer', async(() => {
      const action = new SecurityUpdateToken();

      expect(store.dispatch)
        .toHaveBeenCalledWith(jasmine.objectContaining(action));
    }));
  });

  // TODO: This test has some unintended interaction. If the function initialState() in
  // ecaInitialStateate.ts is renamed then this test fails. That should not happen.
  describe('token undefined', () => {

    beforeEach(async(() => setupTestBed(getInitialState(null))));

    beforeEach(setupSpies);

    it('should not dispatch an undefined token event after timer', async(() => {
      expect(store.dispatch)
        .toHaveBeenCalledTimes(0);
    }));
  });
});
